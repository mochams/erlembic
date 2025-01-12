-module(erlembic).

-export([init/1]).

-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
    {ok, State1} = erlembic_init_prv:init(State),
    {ok, State2} = erlembic_revision_prv:init(State1),
    {ok, State3} = erlembic_upgrade_prv:init(State2),
    {ok, State4} = erlembic_downgrade_prv:init(State3),
    {ok, State4}.
