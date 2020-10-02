-module(commands).
-export([execute/1]).

execute({turn, Value}) -> screen:print(9, Value);
execute({play, sound}) -> 
    MacPlay = os:cmd("which afplay"),
    LinuxPlay = os:cmd("which ffplay"),
    play(MacPlay, LinuxPlay);
execute({progress, Progress}) -> screen:progress(8, color(Progress), Progress);
execute({pomodoro, Progress}) -> screen:progress(0, color(Progress), Progress);
execute(_) -> ok.

color(0.0) -> white;
color(0) -> white;
color(_) ->  green.

play([], _) -> linux_mp3("sounds/yeah.mp3");
play(_, []) -> apple_mp3("sounds/yeah.mp3").

linux_mp3(Sound) -> os:cmd(io_lib:format("ffplay ~p -volume 30 -nodisp -autoexit &", [Sound])).
apple_mp3(Sound) -> os:cmd(io_lib:format("afplay ~p -v .3 &", [Sound])).
