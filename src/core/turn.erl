-module(turn).
-export([print/1, initial_commands/0]).

initial_commands() -> [].

print(Turns = #{current := Current, last:= _}) ->
    sound_commands(Turns) ++ turn_commands(Current) ++ pomodoro_commands(Current).

%% ========================================================
%% Turn
%% ========================================================

turn_commands(#{time_left := TimeLeft, length := Length}) ->
    [turn_time_left(TimeLeft), turn_progress_command(TimeLeft, Length)];
turn_commands(#{time_left := TimeLeft}) -> 
    [turn_time_left(TimeLeft), turn_progress_command(TimeLeft, {1,ms})].

turn_time_left({0,_}) -> {turn, "No turn in progress"};
turn_time_left(TimeLeft) -> {turn, duration:human_readable(TimeLeft) ++ " left in turn"}.

turn_progress_command(TimeLeft,Length) -> 
    Progress = progress(TimeLeft, Length),
    {progress, Progress}.

progress(_, {0, _}) -> 0;
progress(TimeLeft = {_,ms},{Length,min}) -> progress(TimeLeft, {Length * 60 * 1000, ms});
progress({TimeLeft, _}, {Length, _}) -> TimeLeft / Length.

%% ========================================================
%% Pomodoro
%% ========================================================
pomodoro_commands(#{pomodoro := Ratio}) -> [{pomodoro, max(0, 1 - Ratio)}];
pomodoro_commands(_) -> [].

%% ========================================================
%% Sound
%% ========================================================
sound_commands(#{current := #{time_left := {0, _}},
       last := #{time_left := {0, _}}}) -> [];
sound_commands(#{current := #{time_left := {0, _}}}) ->
    [{play, sound}];
sound_commands(_) -> [].
