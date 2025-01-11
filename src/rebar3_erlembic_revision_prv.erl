-module(rebar3_erlembic_revision_prv).

-export([init/1, do/1, format_error/1]).

-define(PROVIDER, revision).
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
        {example, "rebar3 erlembic revision -n create_table_users"},
        % list of options understood by the plugin
        {opts, [
            {
                name,
                $n,
                "name",
                {string, "revision_script"},
                "Name of the SQL file for new revision script."
            }
        ]},
        {short_desc, "Create a new revision file"},
        {desc, "Create a new revision file"}
    ]),
    {ok, rebar_state:add_provider(State, Provider)}.

-spec do(rebar_state:t()) -> {ok, rebar_state:t()} | {error, string()}.
do(State) ->
    {Args, _} = rebar_state:command_parsed_args(State),
    rebar3_erlembic_revision:run(
        rebar3_erlembic_utils:extract_arg_value(Args, name)
    ),
    {ok, State}.

-spec format_error(any()) -> iolist().
format_error(Reason) ->
    io_lib:format("~p", [Reason]).
