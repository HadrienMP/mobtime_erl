-module(status).
-export([parse/1]).

parse(Json) -> 
    Result = jsone:try_decode(list_to_binary(Json)),
    Status = parseResult(Result),
    validate(Status).

parseResult({ok, Decoded, _}) -> {ok, #{timeLeft => {maps:get(<<"timeLeftInMillis">>, Decoded),ms}}};
parseResult({_, Reason}) -> {error, {"Invaid json", {reason, Reason}}}.

validate(StatusResp = {ok, #{timeLeft:={TimeLeft,ms}}}) when is_integer(TimeLeft) -> 
    StatusResp;
validate({ok, _}) -> {error, {reason, "timeLeftInMillis is not an integer"}};
validate(Error) -> Error.
