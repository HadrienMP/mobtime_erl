-module(time_left).
-export([print/2]).

print(MobTurn, LastResult) -> to_result(LastResult, commands(MobTurn)).

commands(#{time_left := TimeLeft}) -> [{print, duration:human_readable(TimeLeft)}].

to_result(#{history := Commands}, Commands) -> #{commands=>[], history => Commands};
to_result(_, Commands) -> #{commands=>Commands, history=>Commands}.
