-module(time_left).
-export([print/1, print/2]).

print(Status, Last) -> 
    PrintCommand = {print, print(Status)},
    Last2 = last(Last),
    case lastPrintCommand(Last) of
        PrintCommand -> [{last, Last2}];
        _ -> [PrintCommand, {last, [PrintCommand]}]
    end.

lastPrintCommand(Result) -> proplists:lookup(print, last(Result)).
last(Commands) -> proplists:get_value(last, Commands, []).

print(#{time_left := TimeLeft}) -> print(TimeLeft);

print({Ms, ms}) when Ms > 59 * 1000 -> to_string(math:ceil(Ms/(60 * 1000))) ++ "min";
print({Ms, ms}) -> to_string(math:ceil(Ms/1000)) ++ "s".

to_string(Number) -> float_to_list(Number, [{decimals, 0}]).
