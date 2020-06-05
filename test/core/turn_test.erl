-module(turn_test).
-include_lib("eunit/include/eunit.hrl").
-import(turn, [print/2]).
-define(minutes_left(Min), #{time_left => {Min * 60 * 1000, ms}}).
-define(no_history, turn:initial_commands()).

'print the time in a human readable way_test'() -> 
    R1 = print(?minutes_left(2), ?no_history),
    ?assertMatch([{print, "2min"}], R1).
    
'signals that the turn ended instead of displaying 0s_test'() -> 
    R2 = print(?minutes_left(0), ?no_history),
    ?assertMatch([{print, "No turn in progress"}], R2).

