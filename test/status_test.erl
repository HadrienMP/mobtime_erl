-module(status_test).
-include_lib("eunit/include/eunit.hrl").

'can be parsed from the server status json_test'() -> 
    ?assertMatch({ok, #{timeLeft:={1000,ms}}}, 
                 status:parse("{\"timeLeftInMillis\":1000}")).

