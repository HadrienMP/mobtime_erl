-module(mobtime).

%% API exports
-export([main/1, display_status/1]).

%%====================================================================
%% Main
%%====================================================================

%% escript Entry point
main([Mob | _]) -> screen:init(),
                   timer:apply_interval(500, ?MODULE, display_status, [Mob]), 
                   {ok, WsPid} = socket_io:connect(),
                   listen_to_keys(Mob, WsPid).

%%====================================================================
%% Listen to keys
%%====================================================================

listen_to_keys(Mob, WsPid) -> 
    case encurses:getch() of
        $q -> quit();
        $r -> socket_io:send(WsPid, "start mob", Mob, [4]);
        $k -> socket_io:send(WsPid, "interrupt mob", Mob);
        $p -> socket_io:send(WsPid, "pomodoro stop", Mob);
        _ -> do_nothing
    end,
    listen_to_keys(Mob, WsPid).

quit() -> screen:close(),
          erlang:halt(0).

%%====================================================================
%% Update status
%%====================================================================

display_status(Mob) -> 
    Turn = server:current_turn(Mob),
    Commands = turn:print(Turn),
    lists:foreach(fun display/1, Commands).

display({turn, Value}) -> screen:print(9, Value);
display({progress, Progress}) -> screen:progress(8, color(Progress), Progress);
display({pomodoro, Progress}) -> screen:progress(0, color(Progress), Progress);
display(_) -> ok.

color(0.0) -> white;
color(0) -> white;
color(_) ->  green.

