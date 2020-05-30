-module(time_interval_test).
-import(time_interval,[print/1]).
-include_lib("eunit/include/eunit.hrl").

'prints seconds under a minute _test'() ->
    ?assertEqual({ok, "2s"}, 
                 print({2000, ms})).

'prints minutes by default_test'() ->
    ?assertEqual({ok, "1min"}, 
                 print({60 * 1000, ms})).

'prints one minute for a little over 59s_test'() ->
    ?assertEqual({ok, "1min"}, 
                 print({59001, ms})).

'rounds to the second up_test'() ->
    ?assertEqual({ok, "2s"}, 
                 print({1001, ms})).

'prints an error for an invalid entry_test'() ->
    ?assertEqual({error, {"Not a valid time format", ""}}, 
                 print("")).

'prints an error for an unhandled unit_test'() ->
    ?assertEqual({error, {"Unit not handled, use ms instead", hours}}, 
                 print({2, hours})).
