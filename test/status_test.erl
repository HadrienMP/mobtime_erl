-module(status_test).
-include_lib("eunit/include/eunit.hrl").

'can be parsed from the server status json_test'() -> 
    ?assertMatch({ok, #{timeLeft:={1000,ms}}}, 
                 status:parse("{\"timeLeftInMillis\":1000}")).

'returns an error for an invalid response_test'() ->
    ?assertMatch({error, _}, status:parse("Ooops")).

'returns an error when timeleft is not an integer_test'() ->
    ?assertMatch({error, {reason, "timeLeftInMillis is not an integer"}}, 
                  status:parse("{\"timeLeftInMillis\":\"toto\"}")).
