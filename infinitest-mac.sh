fswatch -o --exclude=_build . | xargs -n1 -I{} sh -c 'clear && rebar3 eunit'
