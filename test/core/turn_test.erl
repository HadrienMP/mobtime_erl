-module(turn_test).
-include_lib("eunit/include/eunit.hrl").
-import(turn, [print/2]).
-define(minutes_left(Min), #{time_left => {Min * 60 * 1000, ms}}).
-define(no_history, turn:initial_commands()).

'print the time only once when it did not change_test'() -> 
    R1 = print(?minutes_left(2), ?no_history),
    R2 = print(?minutes_left(2), R1),
    R3 = print(?minutes_left(2), R2),

    ?assertMatch(#{commands := [{print, "2min"}]}, R1),
    ?assertMatch(#{commands := []}, R2),
    ?assertMatch(#{commands := []}, R3).
    
'signals that the turn ended instead of displaying 0s_test'() -> 
    R1 = print(?minutes_left(1), ?no_history),
    R2 = print(?minutes_left(0), R1),
    #{commands := Commands} = R2,
    ?assertEqual("No turn in progress", proplists:get_value(print, Commands)).

'does not print turn ended after "no turn in progress"_test'() -> 
    R1 = print(?minutes_left(0), ?no_history),
    R2 = print(?minutes_left(0), R1),
    ?assertMatch(#{commands := []}, R2).

'clear the terminal when a turn has ended_test'() -> 
    R1 = print(?minutes_left(1), ?no_history),
    R2 = print(?minutes_left(0), R1),
    ?assertMatch(#{commands := [{clear} | _]}, R2).
