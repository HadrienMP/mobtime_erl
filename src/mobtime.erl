-module(mobtime).

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main(_) ->
    io:setopts([{encoding, unicode}]),
    print:mob_time(),
    loop("", fun update/1, 1000),
    erlang:halt(0).

%%====================================================================
%% Internal functions
%%====================================================================

loop(Last, Fun, Sleep) ->
    New = Fun(Last),
    timer:sleep(Sleep),
    loop(New, Fun, Sleep).

update(LastResult) -> 
    Turn = server:current_turn(),
    Commands = turn:print(Turn, LastResult),
    lists:foreach(fun execute/1, Commands),
    Commands.

execute({print, Value}) -> io:format(" ~s                     \r", [Value]);
execute(_) -> ok.
