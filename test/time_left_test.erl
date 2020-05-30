-module(time_left_test).
-include_lib("eunit/include/eunit.hrl").
-import(time_left, [print/1]).

'print the time left in the mob in a human readable form_test'() -> 
    ?assertEqual("2s", print("{\"timeLeftInMillis\":2000}")).

'prints the errors when they occur - bad json_test'() -> 
    ?assertEqual({error, {reason, badjson, ""}}, print("")).

'prints the errors when they occur - bad time_test'() -> 
    ?assertMatch({error, _}, print("{\"timeLeftInMillis\":\"toto\"}")).
