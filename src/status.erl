-module(status).
-export([parse/1]).

parse(Json) -> 
    Result = jsone:try_decode(list_to_binary(Json)),
    parseResult(Result).

parseResult({ok, Decoded, _}) -> {ok, #{timeLeft => {maps:get(<<"timeLeftInMillis">>, Decoded),ms}}};
parseResult({_, Reason}) -> {error, {"Invaid json", {reason, Reason}}}.
