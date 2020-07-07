-module(status).
-export([update/1]).


update(Mob) -> 
    Turn = server:current_turn(Mob),
    Commands = turn:print(Turn),
    lists:foreach(fun display/1, Commands),
    timer:sleep(1000),
    update(Mob).

display({turn, Value}) -> 
    io:format(os:cmd("tput cup 9 0")),
    io:format(os:cmd("tput el1")),
    io:format(os:cmd("tput el")),
    io:format(" " ++ Value),
    reset();
display({progress, Progress}) ->
    io:format(os:cmd("tput cup 8 0")),
    io:format("~s~s~s", [color(Progress), progress:bar(Progress, 31), "\033[0m"]),
    reset();
display({pomodoro, Progress}) ->
    io:format(os:cmd("tput cup 0 0")),
    io:format("~s~s~s", [color(Progress), progress:bar(Progress,31), "\033[0m"]),
    reset();
display(_) -> ok.


color(0.0) -> "\033[0m";
color(0) -> "\033[0m";
color(_) ->  "\033[1;32m".

reset() -> io:format(os:cmd("tput cup 11 0")).
