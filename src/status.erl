-module(status).
-export([update/1]).


update(Mob) -> 
    Turn = server:current_turn(Mob),
    Commands = turn:print(Turn),
    lists:foreach(fun display/1, Commands),
    timer:sleep(1000),
    update(Mob).

display({turn, Value}) -> screen:print(9, Value);
display({progress, Progress}) -> screen:progress(8, color(Progress), Progress);
display({pomodoro, Progress}) -> screen:progress(0, color(Progress), Progress);
display(_) -> ok.

color(0.0) -> "\033[0m";
color(0) -> "\033[0m";
color(_) ->  "\033[1;32m".

