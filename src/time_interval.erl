-module(time_interval).
-export([print/1]).

print({Ms, ms}) when not is_integer(Ms) -> {error, {"Not a valid time format", Ms}};
print({Ms, ms}) when Ms > 59 * 1000 -> ok(to_string(math:ceil(Ms/(60 * 1000))) ++ "min");
print({Ms, ms}) -> ok(to_string(math:ceil(Ms/1000)) ++ "s");
print({_, Unit}) -> {error, {"Unit not handled, use ms instead", Unit}};
print(NotHandled) -> {error, {"Not a valid time format", NotHandled}}.

to_string(Number) -> float_to_list(Number, [{decimals, 0}]).

ok(Result) -> {ok, Result}.
