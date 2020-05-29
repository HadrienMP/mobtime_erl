#!/bin/bash

function test() {
    rebar3 eunit --module=$1
    echo -e "\n"
}

export -f test

fswatch -m poll_monitor -o -r -0 . -e "\..*$" -e "_build" -e "\.eunit" | xargs -0 -n 1 -I{} -r bash -c "test $1"
# fswatch -m poll_monitor -r -0 . -e "\.swp" -e "_build" | xargs -0 -n1 echo
# fswatch -r . -o -e "/\..*$" -e "_build" | xargs -n 1 rebar eunit
