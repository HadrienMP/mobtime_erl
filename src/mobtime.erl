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
    loop(fun update/0, 1000),
    erlang:halt(0).

%%====================================================================
%% Internal functions
%%====================================================================

loop(Fun, Sleep) ->
    Fun(),
    timer:sleep(Sleep),
    loop(Fun, Sleep).

update() -> 
    Turn = server:current_turn(),
    Commands = turn:print(Turn),
    lists:foreach(fun execute/1, Commands).

execute({turn, Value}) -> 
    io:format(os:cmd("tput el1")),
    io:format(os:cmd("tput el")),
    io:format("\r ~s ", [Value]);
execute(_) -> ok.
