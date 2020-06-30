-module(progress).
-export([bar/2]).

bar(Ratio,Length) -> "|" ++ inner(Ratio,Length)  ++ "|".

inner(Progress, BarLength) when Progress < 0 -> inner(0, BarLength);
inner(Progress,BarLength) -> 
    Full = math:ceil(Progress * BarLength),
    times("#", Full) ++ times("-", BarLength - Full).

times(Char, Number) -> times(Char, Number, "").
times(_, Number, Acc) when Number =< 0 -> Acc;
times(Char, Number, Acc) -> times(Char, Number -1, Acc ++ Char).
