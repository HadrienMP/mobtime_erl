-module(print).
-export([mob_time/0]).

mob_time() ->
    io:format("|-------------------------------|~n"),
    io:format("|    _______  _____  ______     |~n"),
    io:format("|    |  |  | |     | |_____]    |~n"),
    io:format("|    |  |  | |_____| |_____]    |~n"),
    io:format("| _______ _____ _______ _______ |~n"),
    io:format("|    |      |   |  |  | |______ |~n"),
    io:format("|    |    __|__ |  |  | |______ |~n"),
    io:format("|                               |~n"),
    io:format("|-------------------------------|~n"),
    io:nl().

