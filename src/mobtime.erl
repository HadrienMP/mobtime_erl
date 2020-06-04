-module(mobtime).

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main(_) ->
    loop("", fun display_time_left/1, 1000),
    erlang:halt(0).

%%====================================================================
%% Internal functions
%%====================================================================

loop(Last, Fun, Sleep) ->
    New = Fun(Last),
    timer:sleep(Sleep),
    loop(New, Fun, Sleep).

display_time_left(Last) -> 
    Status = server:status(),
    Result = #{to_execute := Commands} = time_left:print(Status, Last),
    lists:foreach(fun execute/1, Commands),
    Result.

execute({print, Value}) -> io:format("~p~n", [Value]);
execute(_) -> ok.
