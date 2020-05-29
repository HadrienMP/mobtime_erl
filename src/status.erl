-module(status).
-export([parse/1]).

parse(Json) -> 
    Decoded = jsone:decode(list_to_binary(Json)),
    #{timeLeft => 
      {maps:get(<<"timeLeftInMillis">>, Decoded),ms}
     }.
