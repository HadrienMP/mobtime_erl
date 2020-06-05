-module(turn_test).
-include_lib("eunit/include/eunit.hrl").
-import(turn, [print/1]).
-define(minutes_left(Min), #{time_left => {Min * 60 * 1000, ms}}).

'print the time in a human readable way_test'() -> 
    R1 = print(?minutes_left(2)),
    ?assertMatch([{turn, "2min left in turn"}], R1).
    
'signals that the turn ended instead of displaying 0s_test'() -> 
    R2 = print(?minutes_left(0)),
    ?assertMatch([{turn, "No turn in progress"}], R2).

