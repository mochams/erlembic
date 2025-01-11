-module(rebar3_erlembic_revision).

-export([run/1]).

run(Name) ->
    io:format("revision, ~p~n", [Name]).
