-module(turn).
-export([print/2, initial_commands/0]).

initial_commands() -> #{commands=>[], history=>[]}.

print(MobTurn, LastResult) -> to_result(LastResult, commands(MobTurn)).

commands(#{time_left := {0,_}}) -> [{print, "No turn in progress"}];
commands(#{time_left := TimeLeft}) -> [{print, duration:human_readable(TimeLeft)}].

to_result(#{history := Commands}, Commands) -> #{commands=>[], history => Commands};
to_result(_, Commands) -> #{commands=>Commands, history=>Commands}.
