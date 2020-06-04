#!/bin/bash

function test() {
    clear
    rebar3 eunit --module=$1
    echo -e "\n"
}

if [[ $1 = "mac" ]]; then
    fswatch -o --exclude=_build . | xargs -n1 -I{} sh -c 'clear && rebar3 eunit'
else
    export -f test
    fswatch -m poll_monitor -o -r -0 . -e "\..*$" -e "_build" -e "\.eunit" | xargs -0 -n 1 -I{} -r bash -c "test $1"
fi
