-module(time_left).
-export([print/1]).

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

