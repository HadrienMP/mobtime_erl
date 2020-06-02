-module(status).
-export([parse/1]).

parse(Json) -> 
    Result = jsone:try_decode(list_to_binary(Json)),
    Status = parse_result(Result),
    validate(Status).

parse_result({ok, Decoded, _}) -> {ok, #{timeLeft => {maps:get(<<"timeLeftInMillis">>, Decoded),ms}}};
parse_result({_, Reason}) -> {error, {"Invaid json", {reason, Reason}}}.

validate(StatusResp = {ok, #{timeLeft:={TimeLeft,ms}}}) when is_integer(TimeLeft) -> 
    StatusResp;
validate({ok, _}) -> {error, {reason, "timeLeftInMillis is not an integer"}};
validate(Error) -> Error.
