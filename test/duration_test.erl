-module(duration_test).
-include_lib("eunit/include/eunit.hrl").
-import(duration, [human_readable/1]).
-define(ms_left(Ms), {Ms, ms}).

'print the time left as seconds under a minute_test'() -> 
    Results = human_readable(?ms_left(2000)),
    ?assertMatch(("2s"), Results).

'print the time left as minutes otherwise_test'() -> 
    Result = human_readable(?ms_left(60000)),
    ?assertMatch(("1min"), Result).

'print, rounds to the upper second_test'() -> 
    Result = human_readable(?ms_left(1001)),
    ?assertMatch(("2s"), Result).

'print, round to the upper minute_test'() -> 
    Result = human_readable(?ms_left(61000)),
    ?assertMatch(("2min"), Result).
