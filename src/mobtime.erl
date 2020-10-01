-module(mobtime).

%% API exports
-export([main/1, keep_displaying_status/1]).

%%====================================================================
%% Main
%%====================================================================

%% escript Entry point
main([Mob | _]) -> screen:init(),
                   spawn_link(?MODULE, keep_displaying_status, [Mob]), 
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

keep_displaying_status(Mob) ->
    LastTurn = display_status(Mob),
    timer:sleep(1000),
    keep_displaying_status(Mob, LastTurn).

keep_displaying_status(Mob, LastTurn) ->
    Current = display_status(Mob, LastTurn),
    timer:sleep(1000),
    keep_displaying_status(Mob, Current).

display_status(Mob) -> 
    Turn = server:current_turn(Mob),
    Commands = turn:print(#{current => Turn, last => Turn}),
    lists:foreach(fun execute/1, Commands),
    Turn.

display_status(Mob, LastTurn) -> 
    Turn = server:current_turn(Mob),
    Commands = turn:print(#{current => Turn, last => LastTurn}),
    lists:foreach(fun execute/1, Commands),
    Turn.

execute({turn, Value}) -> screen:print(9, Value);
execute({play, sound}) -> screen:print(10, "Play");
execute({progress, Progress}) -> screen:progress(8, color(Progress), Progress);
execute({pomodoro, Progress}) -> screen:progress(0, color(Progress), Progress);
execute(_) -> ok.

color(0.0) -> white;
color(0) -> white;
color(_) ->  green.

