-module(mobtime).
-include_lib("encurses/include/encurses.hrl").

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main([Mob | _]) ->
    encurses:initscr(),
    encurses:noecho(),
    encurses:curs_set(?CURS_INVISIBLE),
    encurses:refresh(),
    print:mob_time(),
    spawn_link(status, update, [Mob]), 
    {ok, WsPid} = socket_io:connect(),
    listen_to_keys(list_to_binary(Mob), WsPid).

%%====================================================================
%% Internal functions
%%====================================================================

listen_to_keys(Mob, WsPid) -> 
    case encurses:getch() of
        $q -> quit();
        $r -> socket_io:send(WsPid, jsone:encode([<<"start mob">>, Mob, 4]));
        $k -> socket_io:send(WsPid, jsone:encode([<<"interrupt mob">>, Mob]));
        $p -> socket_io:send(WsPid, jsone:encode([<<"pomodoro stop">>, Mob]));
        _ -> do_nothing
    end,
    listen_to_keys(Mob, WsPid).

quit() ->
    encurses:endwin(),
    erlang:halt(0).
