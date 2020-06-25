-module(server).
-export([current_turn/0]).
-on_load(setup/0).

setup() -> 
    ssl:start(),
    {ok, _} = application:ensure_all_started(inets),
    ok.

current_turn() ->
    {ok,{_, _, Body}} = httpc:request("https://mob-time-server.herokuapp.com/fwg/status"),
    parse(Body).

parse(Json) -> 
    Result = jsone:decode(list_to_binary(Json)),
    parse_result(Result).

parse_result(Map) -> 
    #{
        time_left => time_left_in_turn(Map), 
        length => turn_length(Map),
        pomodoro => pomodoro(Map)
     }.

time_left_in_turn(#{<<"timeLeftInMillis">> := TimeLeft}) 
  when is_integer(TimeLeft) -> {TimeLeft, ms};
time_left_in_turn(_) -> {0, ms}.

turn_length(#{<<"lengthInMinutes">> := Length}) -> {Length, min};
turn_length(_) -> {0, min}.

pomodoro(#{<<"pomodoro">> := #{<<"ratio">> := Ratio}}) -> Ratio;
pomodoro(_) -> 0.

