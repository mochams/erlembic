-module(rebar3_erlembic_init).

-export([run/1]).

run(Directory) ->
    io:format("init, ~p~n", [Directory]).
