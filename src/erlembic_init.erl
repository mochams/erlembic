-module(erlembic_init).

-export([run/1]).

run(Directory) ->
    io:format("current path, ~p~n", [erlembic_utils:project_root()]),
    io:format("init, ~p~n", [Directory]).
