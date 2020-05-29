-module(status).
-export([parse/1]).

parse(Json) -> 
    Decoded = jsone:decode(list_to_binary(Json)),
    {ok, 
     #{timeLeft => 
      {maps:get(<<"timeLeftInMillis">>, Decoded),ms}
     }
    }.
