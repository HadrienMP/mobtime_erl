-module(duration).
-export([human_readable/1]).

human_readable({Ms, ms}) when Ms > 59 * 1000 -> to_string(math:ceil(Ms/(60 * 1000))) ++ "min";
human_readable({Ms, ms}) -> to_string(math:ceil(Ms/1000)) ++ "s".

to_string(Number) -> float_to_list(Number, [{decimals, 0}]).
