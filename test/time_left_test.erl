-module(time_left_test).
-include_lib("eunit/include/eunit.hrl").
-import(time_left, [print/2]).
-define(ms_left(Ms), #{time_left => {Ms, ms}}).
-define(minutes_left(Min), #{time_left => {Min * 60 * 1000, ms}}).

'print the time left as seconds under a minute_test'() -> 
    Commands = print(?ms_left(2000), []),
    ?assertEqual("2s", proplists:get_value(print, Commands)).

'print the time left as minutes otherwise_test'() -> 
    Commands = print(?ms_left(60000), []),
    ?assertEqual("1min", proplists:get_value(print, Commands)).

'print, rounds to the upper second_test'() -> 
    Commands = print(?ms_left(1001), []),
    ?assertEqual("2s", proplists:get_value(print, Commands)).

'print, round to the upper minute_test'() -> 
    Commands = print(?ms_left(61000), []),
    ?assertEqual("2min", proplists:get_value(print, Commands)).

'print the time only once when it did not change_test'() -> 
    C1 = print(?minutes_left(2), []),
    C2 = print(?minutes_left(2), C1),
    C3 = print(?minutes_left(2), C2),
    ?assertEqual({print, "2min"}, proplists:lookup(print, C1)),
    ?assertEqual(none, proplists:lookup(print, C2)),
    ?assertEqual(none, proplists:lookup(print, C3)).
    
