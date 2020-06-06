-module(turn).
-export([print/1, initial_commands/0]).

initial_commands() -> [].

print(MobTurn) -> commands(MobTurn).

commands(#{time_left := TimeLeft, length := Length}) ->
    [time_left(TimeLeft), progress_command(TimeLeft, Length)];
commands(#{time_left := TimeLeft}) -> 
    [time_left(TimeLeft), progress_command(TimeLeft, {1,ms})].

time_left({0,_}) -> {turn, "No turn in progress"};
time_left(TimeLeft) -> {turn, duration:human_readable(TimeLeft) ++ " left in turn"}.

progress_command(TimeLeft,Length) -> 
    Progress = progress(TimeLeft, Length) * 10,
    Bar = progress_bar(Progress, ""),
    {progress, "|" ++ Bar ++ "|"}.

progress(_, {0, _}) -> 0;
progress(TimeLeft = {_,ms},{Length,min}) -> progress(TimeLeft, {Length * 60 * 1000, ms});
progress({TimeLeft, _}, {Length, _}) -> TimeLeft / Length.

progress_bar(_, Bar) when length(Bar) =:= 10 -> Bar;
progress_bar(Progress, Bar) when Progress > length(Bar) -> progress_bar(Progress, Bar ++ "▓");
progress_bar(Progress, Bar) -> progress_bar(Progress, Bar ++ " ").


