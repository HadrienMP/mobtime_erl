-module(turn_test).
-include_lib("eunit/include/eunit.hrl").
-import(turn, [print/1]).
-define(minutes_left(Min), #{time_left => {Min * 60 * 1000, ms}}).
-define(minutes(Min), {Min * 60 * 1000, ms}).

'print the time in a human readable way_test'() -> 
    assertContains({turn, "2min left in turn"}, print(?minutes_left(2))).
    
'signals that the turn ended instead of displaying 0s_test'() -> 
    assertContains({turn, "No turn in progress"}, print(?minutes_left(0))).

'the progressbar is empty when no turn is in progress_test'() ->
    Commands = print(?minutes_left(0)),
    assertContains({progress, "|          |"}, Commands).

'the progressbar is one square when there is 10% of the time left_test'() ->
    Commands = print(#{time_left => {1, ms}, length => {10, ms}}),
    assertContains({progress, "|▓         |"}, Commands).

'the progressbar is two squares when there is 20% of the time left_test'() ->
    Commands = print(#{time_left => {2, ms}, length => {10, ms}}),
    assertContains({progress, "|▓▓        |"}, Commands).

'the progressbar is three squares when there is 30% of the time left_test'() ->
    Commands = print(#{time_left => {30, ms}, length => {100, ms}}),
    assertContains({progress, "|▓▓▓       |"}, Commands).

'the progressbar works with different units_test'() ->
    Commands = print(#{time_left => {1 * 60 * 1000, ms}, length => {10, min}}),
    assertContains({progress, "|▓         |"}, Commands).

'the progressbar is empty when the length is 0_test'() ->
    Commands = print(#{time_left => {1 * 60 * 1000, ms}, length => {0, min}}),
    assertContains({progress, "|          |"}, Commands).
    
assertContains({Key, Value}, PropList) -> 
    ?assertEqual(Value, proplists:get_value(Key, PropList)).
