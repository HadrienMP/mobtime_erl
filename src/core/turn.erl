-module(turn).
-export([print/1, initial_commands/0]).

initial_commands() -> [].

print(MobTurn) -> commands(MobTurn).

commands(#{time_left := {0,_}}) -> [{print, "No turn in progress"}];
commands(#{time_left := TimeLeft}) -> [{print, duration:human_readable(TimeLeft)}].
