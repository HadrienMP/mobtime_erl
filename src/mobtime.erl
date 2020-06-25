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
    WsPid = spawn_link(websocket, init, []),
    wait_q(WsPid),
    encurses:endwin(),
    erlang:halt(0).

%%====================================================================
%% Internal functions
%%====================================================================

wait_q(WsPid) -> 
    case encurses:getch() of
        $q -> ok;
        $r -> WsPid ! start,
              wait_q(WsPid);
        $k -> WsPid ! stop,
              wait_q(WsPid);
        _ -> wait_q(WsPid)
    end.

