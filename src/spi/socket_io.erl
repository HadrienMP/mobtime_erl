-module(socket_io).
-export([connect/0, keep_alive/1, send/2]).

connect() ->
    {ok, _} = application:ensure_all_started(gun),
    connect_websocket().

connect_websocket() ->
    {ok, ConnPid} = connect_server(),
    gun:ws_upgrade(ConnPid, "/socket.io/?EIO=3&transport=websocket"),
    receive
        {gun_upgrade, ConnPid, _, _, _} -> 
            timer:apply_interval(20000, ?MODULE, keep_alive, [ConnPid]), 
            {ok, ConnPid};
        {gun_response, ConnPid, _, _, Status, Headers} ->
            exit({ws_upgrade_failed, Status, Headers});
        {gun_error, ConnPid, _, Reason} ->
            exit({ws_upgrade_failed, Reason})
        %% More clauses here as needed.
    after 1000 ->
        exit(timeout)
    end.

connect_server() ->
    {ok, ConnPid} = gun:open("mob-time-server.herokuapp.com", 443),
    {ok, _} = gun:await_up(ConnPid),
    {ok, ConnPid}.

send(WsPid, Msg) -> gun:ws_send(WsPid, {text, "42" ++ Msg}).

keep_alive(Pid) -> gun:ws_send(Pid, {text, "2probe"}).
