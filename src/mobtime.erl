-module(mobtime).

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main(_) ->
    encurses:initscr(),
    encurses:refresh(),
    print:mob_time(),
    spawn_link(status, update, []),
    wait_q(),
    encurses:endwin(),
    erlang:halt(0).

%%====================================================================
%% Internal functions
%%====================================================================

wait_q() -> 
    case encurses:getch() of
        $q -> ok;
        _ -> wait_q()
    end.

