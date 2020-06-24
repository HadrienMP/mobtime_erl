-module(websocket).
-on_load(setup/0).
-export([init/0, keep_alive/1]).

setup() -> 
    {ok, _} = application:ensure_all_started(gun),
    ok.

init() ->
    {ok, BasicPid} = connect_server(),
    {ok, WsPid} = connect_websocket(),
    timer:apply_interval(20000, ?MODULE, keep_alive, [WsPid]), 
    listen(BasicPid, WsPid).

connect_websocket() ->
    {ok, ConnPid} = connect_server(),
    gun:ws_upgrade(ConnPid, "/socket.io/?EIO=3&transport=websocket"),
    receive
        {gun_upgrade, ConnPid, _, _, _} -> {ok, ConnPid};
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

listen(BasicPid, WsPid) ->
    receive
        start -> gun:ws_send(WsPid, {text, "42[\"start mob\",\"fwg\",4]"});
        {Sender, status} -> Sender ! {status, status(BasicPid)}
    end,
    listen(BasicPid, WsPid).

status(ConnPid) ->
    StreamRef = gun:get(ConnPid, "/fwg/status"),
    {response, nofin, _, _} = gun:await(ConnPid, StreamRef),
    {ok, Body} = gun:await_body(ConnPid, StreamRef),
    parse_status(Body).

parse_status(Json) -> 
    Result = jsone:decode(Json),
    parse_result(Result).

parse_result(#{<<"timeLeftInMillis">> := TimeLeft, <<"lengthInMinutes">> := Length}) 
  when is_integer(TimeLeft) -> 
    #{time_left => {TimeLeft ,ms}, length => {Length, min}}.

keep_alive(Pid) -> gun:ws_send(Pid, {text, "2probe"}).
