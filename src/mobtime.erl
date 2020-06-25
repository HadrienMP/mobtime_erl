-module(mobtime).
-include_lib("encurses/include/encurses.hrl").

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main(_) ->
    encurses:initscr(),
    encurses:noecho(),
    encurses:curs_set(?CURS_INVISIBLE),
    encurses:refresh(),
    print:mob_time(),
    spawn_link(status, update, []),
    {ok, WsPid} = socket_io:connect(),
    listen_to_keys(WsPid).

%%====================================================================
%% Internal functions
%%====================================================================

listen_to_keys(WsPid) -> 
    case encurses:getch() of
        $q -> quit();
        $r -> socket_io:send(WsPid, "[\"start mob\",\"fwg\",4]");
        $k -> socket_io:send(WsPid, "[\"interrupt mob\",\"fwg\"]");
        _ -> do_nothing
    end,
    listen_to_keys(WsPid).

quit() ->
    encurses:endwin(),
    erlang:halt(0).
