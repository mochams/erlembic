-module(rebar3_erlembic_upgrade_prv).

-export([init/1, do/1, format_error/1]).

-define(PROVIDER, upgrade).
-define(NAMESPACE, erlembic).
-define(DEPS, [{default, app_discovery}]).

%% ===================================================================
%% Public API
%% ===================================================================
-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
    Provider = providers:create([
        % The 'user friendly' name of the task
        {name, ?PROVIDER},
        % The namespace of the task
        {namespace, ?NAMESPACE},
        % The module implementation of the task
        {module, ?MODULE},
        % The task can be run by the user, always true
        {bare, true},
        % The list of dependencies
        {deps, ?DEPS},
        % How to use the plugin
        {example, "rebar3 erlembic upgrade -r 1"},
        % list of options understood by the plugin
        {opts, [
            {
                revision,
                $n,
                "revision",
                {integer, -1},
                "Number of the revision script."
            }
        ]},
        {short_desc, "Upgrade to a later version"},
        {desc, "Upgrade to a later version"}
    ]),
    {ok, rebar_state:add_provider(State, Provider)}.

-spec do(rebar_state:t()) -> {ok, rebar_state:t()} | {error, string()}.
do(State) ->
    {Args, _} = rebar_state:command_parsed_args(State),
    rebar3_erlembic_upgrade:run(
        rebar3_erlembic_utils:extract_arg_value(Args, revision)
    ),
    {ok, State}.

-spec format_error(any()) -> iolist().
format_error(Reason) ->
    io_lib:format("~p", [Reason]).
