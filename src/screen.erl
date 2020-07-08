-module(screen).
-compile(export_all).
-include_lib("encurses/include/encurses.hrl").

init() ->  
    encurses:initscr(),
    encurses:noecho(),
    encurses:curs_set(?CURS_INVISIBLE),
    encurses:refresh().

close() -> encurses:endwin().

progress(Line, Color, Progress) -> 
    io:format(os:cmd(io_lib:format("tput cup ~p 0", [Line]))),
    io:format(io_lib:format("~s~s~s", [Color, progress:bar(Progress,31), "\033[0m"])).

print(Line, Content) -> 
    io:format(os:cmd(io_lib:format("tput cup ~p 0", [Line]))),
    io:format(os:cmd("tput el1")),
    io:format(os:cmd("tput el")),
    io:format(" " ++ Content).
