-module(screen).
-export([init/0, close/0, progress/3, print/2]).
-include_lib("encurses/include/encurses.hrl").

init() ->  
    encurses:initscr(),
    encurses:noecho(),
    encurses:curs_set(?CURS_INVISIBLE),
    encurses:refresh(),
    mob_time().

close() -> encurses:endwin().

progress(Line, Color, Progress) -> 
    io:format(os:cmd(io_lib:format("tput cup ~p 0", [Line]))),
    io:format(io_lib:format("~s~s~s", [color(Color), progress:bar(Progress,31), "\033[0m"])),
    io:format(os:cmd("tput cup 10 0")).

color(green) ->  "\033[1;32m";
color(_) -> "\033[0m".

print(Line, Content) -> 
    io:format(os:cmd(io_lib:format("tput cup ~p 0", [Line]))),
    io:format(os:cmd("tput el1")),
    io:format(os:cmd("tput el")),
    io:format(" " ++ Content),
    io:format(os:cmd("tput cup 10 0")).

mob_time() ->
    io:format("|-------------------------------|~n\r"),
    io:format("|    _______  _____  ______     |~n\r"),
    io:format("|    |  |  | |     | |_____]    |~n\r"),
    io:format("|    |  |  | |_____| |_____]    |~n\r"),
    io:format("| _______ _____ _______ _______ |~n\r"),
    io:format("|    |      |   |  |  | |______ |~n\r"),
    io:format("|    |    __|__ |  |  | |______ |~n\r"),
    io:format("|                               |~n\r"),
    io:format("|-------------------------------|~n\r"),
    io:nl().
