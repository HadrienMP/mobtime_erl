-module(time_left).
-export([print/1]).

print(Json) -> 
    StatusResp = status:parse(Json),
    case StatusResp of
        {ok, Status} -> print_time_left(Status, {error, bad_time, Json});
        {error, _} -> {error, {reason, badjson, Json}}
    end.
    
print_time_left(Status, Error) ->
    TimeLeft = maps:get(timeLeft, Status),
    PrintResp = time_interval:print(TimeLeft),
    case PrintResp of
        {ok, Print} -> Print;
        _ -> Error
    end.

