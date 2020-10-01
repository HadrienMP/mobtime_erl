-module(turn_test).
-include_lib("eunit/include/eunit.hrl").
-import(turn, [print/1]).
-define(minutes_left(Min), #{time_left => {Min * 60 * 1000, ms}}).
-define(minutes(Min), {Min * 60 * 1000, ms}).

'print the time in a human readable way_test'() -> 
    assertContains({turn, "2 min left in turn"}, print(?minutes_left(2))).
    
'signals that the turn ended instead of displaying 0s_test'() -> 
    assertContains({turn, "No turn in progress"}, print(?minutes_left(0))).

'the progress works with different units_test'() ->
    Commands = print(#{time_left => {1 * 60 * 1000, ms}, length => {10, min}}),
    assertContains({progress, 0.1}, Commands).

'the progress is 0 when the length is 0_test'() ->
    Commands = print(#{time_left => {1 * 60 * 1000, ms}, length => {0, min}}),
    assertContains({progress, 0}, Commands).
    
assertContains({Key, Value}, PropList) -> 
    ?assertEqual(Value, proplists:get_value(Key, PropList)).
