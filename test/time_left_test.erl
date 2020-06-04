-module(time_left_test).
-include_lib("eunit/include/eunit.hrl").
-import(time_left, [print/2]).
-define(minutes_left(Min), #{time_left => {Min * 60 * 1000, ms}}).

'print the time only once when it did not change_test'() -> 
    R1 = print(?minutes_left(2), []),
    R2 = print(?minutes_left(2), R1),
    R3 = print(?minutes_left(2), R2),

    ?assertMatch(#{commands := [{print, "2min"}]}, R1),
    ?assertMatch(#{commands := []}, R2),
    ?assertMatch(#{commands := []}, R3).
    
