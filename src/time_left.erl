-module(time_left).
-export([print/2]).

print(Status, LastResult) -> to_result(LastResult, commands(Status)).

commands(#{time_left := TimeLeft}) -> [{print, duration:human_readable(TimeLeft)}].

to_result(#{history := Commands}, Commands) -> #{to_execute=>[], history => Commands};
to_result(_, Commands) -> #{to_execute=>Commands, history=>Commands}.
