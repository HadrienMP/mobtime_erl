-module(turn_test).
-include_lib("eunit/include/eunit.hrl").
-import(turn, [print/1]).
-define(minutes_left(Min), #{time_left => {Min * 60 * 1000, ms}}).
-define(minutes(Min), {Min * 60 * 1000, ms}).

'print the time in a human readable way_test'() -> 
    Actual = print(#{current => ?minutes_left(2),
                     last => ?minutes_left(2)}),
    assertContains({turn, "2 min left in turn"}, Actual).
    
'signals that the turn ended instead of displaying 0s_test'() -> 
    Actual = print(#{current => ?minutes_left(0),
                     last => ?minutes_left(0)}),
    assertContains({turn, "No turn in progress"}, Actual).

'play a sound when a turn ends_test'() -> 
    Actual = print(#{current => ?minutes_left(0), 
                     last => ?minutes_left(1)}),
    assertContains({play, sound}, Actual).

'doesnt play a sound when a turn didnt end_test'() -> 
    Actual = print(#{current => ?minutes_left(1), 
                     last => ?minutes_left(2)}),
    ?assertNot(proplists:is_defined(play, Actual)).

'doesnt play a sound when the ended before_test'() -> 
    Actual = print(#{current => ?minutes_left(0), 
                     last => ?minutes_left(0)}),
    ?assertNot(proplists:is_defined(play, Actual)).

'the progress works with different units_test'() ->
    Commands = print(#{current => #{time_left => {1 * 60 * 1000, ms}, length => {10, min}},
                       last => ?minutes_left(0)}),
    assertContains({progress, 0.1}, Commands).

'the progress is 0 when the length is 0_test'() ->
    Commands = print(#{current => #{time_left => {1 * 60 * 1000, ms}, length => {0, min}},
                       last => ?minutes_left(0)}),
    assertContains({progress, 0}, Commands).
    
assertContains({Key, Value}, PropList) -> 
    ?assertEqual(Value, proplists:get_value(Key, PropList)).
