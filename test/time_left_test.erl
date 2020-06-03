-module(time_left_test).
-include_lib("eunit/include/eunit.hrl").
-import(time_left, [print/1,print/2]).
-define(ms_left(Ms), #{time_left => {Ms, ms}}).
-define(minutes_left(Min), #{time_left => {Min * 60 * 1000, ms}}).

'print the time left as seconds under a minute_test'() -> 
    ?assertEqual("2s", print(?ms_left(2000))).

'print the time left as minutes otherwise_test'() -> 
    ?assertEqual("1min", print(?ms_left(60000))).

'print, rounds to the upper second_test'() -> 
    ?assertEqual("2s", print(?ms_left(1001))).

'print, round to the upper minute_test'() -> 
    ?assertEqual("2min", print(?ms_left(61000))).

'print the time when it did not change_test'() ->
    LastCommands = print(?minutes_left(2), []),
    Commands = print(?minutes_left(2), LastCommands),
    ?assertEqual([], Commands).

'print the time when it changed_test'() ->
    LastCommands = print(?minutes_left(3), []),
    Commands = print(?minutes_left(2), LastCommands),
    ?assertEqual([{print, "2min"}], Commands).
