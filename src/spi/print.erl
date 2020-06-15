-module(print).
-export([mob_time/0]).

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

