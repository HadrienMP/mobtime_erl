-module(turn).
-export([print/1, initial_commands/0]).

initial_commands() -> [].

print(MobTurn) -> commands(MobTurn).

commands(#{time_left := {0,_}}) -> [{turn, "No turn in progress"}];
commands(#{time_left := TimeLeft}) -> [{turn, duration:human_readable(TimeLeft) ++ " left in turn"}].
