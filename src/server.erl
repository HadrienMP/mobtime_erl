-module(server).
-export([status/0]).
-on_load(setup/0).

setup() -> 
    ssl:start(),
    {ok, _} = application:ensure_all_started(inets),
    ok.

status() ->
    {ok,{_, _, Body}} = httpc:request("https://mob-time-server.herokuapp.com/fwg/status"),
    parse(Body).

parse(Json) -> 
    Result = jsone:decode(list_to_binary(Json)),
    parse_result(Result).

parse_result(#{<<"timeLeftInMillis">> := TimeLeft}) 
  when is_integer(TimeLeft) -> 
    #{time_left => {TimeLeft ,ms}}.
