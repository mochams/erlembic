-module(erlembic_upgrade).

-export([run/1]).

run(Revision) ->
    io:format("upgrade, ~p~n", [Revision]).
