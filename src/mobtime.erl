-module(mobtime).

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main(_) ->
    setup(),
    loop("", fun displayTimeLeft/1, 1000),
    erlang:halt(0).

%%====================================================================
%% Internal functions
%%====================================================================

loop(Last, Fun, Sleep) ->
    New = Fun(Last),
    timer:sleep(Sleep),
    loop(New, Fun, Sleep).

setup() ->
    ssl:start(),
    application:start(inets).

displayTimeLeft(Last) -> 
    {ok,{_, _, Body}} = httpc:request("https://mob-time-server.herokuapp.com/fwg/status"),
    TimeLeft = time_left:print(Body),
    case TimeLeft of
        Last -> Last;
        _ -> os:cmd("echo -e \"toto\""),
             TimeLeft
    end.
