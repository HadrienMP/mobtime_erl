-module(time_left_test).
-include_lib("eunit/include/eunit.hrl").

'print the time left in the mob in a human readable form_test'() -> 
    ?assertEqual("2s", print("{\"timeLeftInMillis\":2000}")).

'prints the errors when they occur - bad json_test'() -> 
    ?assertEqual({error, {reason, badjson, ""}}, print("")).

%'prints the errors when they occur - bad time_test'() -> 
%    ?assertEqual({error, {reason, bad_time, "toto"}}, print("{\"timeLeftInMillis\":\"toto\"}")).

print(Json) -> 
    StatusResp = status:parse(Json),
    case StatusResp of
        {ok, Status} -> printTimeLeft(Status, {error, bad_time, Json});
        {error, _} -> {error, {reason, badjson, Json}}
    end.
    
printTimeLeft(Status, Error) ->
    TimeLeft = maps:get(timeLeft, Status),
    PrintResp = time_interval:print(TimeLeft),
    case PrintResp of
        {ok, Print} -> Print;
        _ -> Error
    end.
