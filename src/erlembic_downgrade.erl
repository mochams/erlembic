-module(erlembic_downgrade).

-export([run/1]).

run(Revision) ->
    io:format("downgrade, ~p~n", [Revision]).
