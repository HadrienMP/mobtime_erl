fswatch -o --exclude=_build . | xargs -n1 -I{} rebar3 eunit
