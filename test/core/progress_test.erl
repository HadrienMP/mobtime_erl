-module(progress_test).
-include_lib("eunit/include/eunit.hrl").

'full one slot bar_test'() -> 
    ?assertEqual("|#|", progress:bar(1,1)).

'empty one slot bar_test'() -> 
    ?assertEqual("|-|", progress:bar(0,1)).

'empty two slots bar_test'() -> 
    ?assertEqual("|--|", progress:bar(0,2)).

'full two slots bar_test'() -> 
    ?assertEqual("|##|", progress:bar(1,2)).

'half full two slots bar_test'() -> 
    ?assertEqual("|#-|", progress:bar(0.5,2)).

'half full two slots bar, less than 50% progress_test'() -> 
    ?assertEqual("|#-|", progress:bar(0.49,2)).

'big bar_test'() -> 
    ?assertEqual("|######################--------|", progress:bar(0.71,30)).

