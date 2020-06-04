-module(time_left_test).
-include_lib("eunit/include/eunit.hrl").
-import(time_left, [print/2]).
-define(ms_left(Ms), #{time_left => {Ms, ms}}).
-define(minutes_left(Min), #{time_left => {Min * 60 * 1000, ms}}).
-define(print(V), #{to_execute := [{print, V}]}).

'print the time left as seconds under a minute_test'() -> 
    Results = print(?ms_left(2000), []),
    ?assertMatch(?print("2s"), Results).

'print the time left as minutes otherwise_test'() -> 
    Result = print(?ms_left(60000), []),
    ?assertMatch(?print("1min"), Result).

'print, rounds to the upper second_test'() -> 
    Result = print(?ms_left(1001), []),
    ?assertMatch(?print("2s"), Result).

'print, round to the upper minute_test'() -> 
    Result = print(?ms_left(61000), []),
    ?assertMatch(?print("2min"), Result).

'print the time only once when it did not change_test'() -> 
    R1 = print(?minutes_left(2), []),
    R2 = print(?minutes_left(2), R1),
    R3 = print(?minutes_left(2), R2),

    ?assertMatch(?print("2min"), R1),
    ?assertMatch(#{to_execute := []}, R2),
    ?assertMatch(#{to_execute := []}, R3).
    
