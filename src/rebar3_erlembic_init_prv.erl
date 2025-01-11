-module(rebar3_erlembic_init_prv).

-export([init/1, do/1, format_error/1]).

-define(PROVIDER, init).
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
        {example, "rebar3 erlembic init -d erlembic"},
        % list of options understood by the plugin
        {opts, [
            {
                directory,
                $d,
                "directory",
                {string, "erlembic"},
                "Name of target directory to set the environment."
            }
        ]},
        {short_desc, "Initialize erlembic environment"},
        {desc, "Initialize erlembic environment"}
    ]),
    {ok, rebar_state:add_provider(State, Provider)}.

-spec do(rebar_state:t()) -> {ok, rebar_state:t()} | {error, string()}.
do(State) ->
    {Args, _} = rebar_state:command_parsed_args(State),
    rebar3_erlembic_init:run(
        rebar3_erlembic_utils:extract_arg_value(Args, directory)
    ),
    {ok, State}.

-spec format_error(any()) -> iolist().
format_error(Reason) ->
    io_lib:format("~p", [Reason]).
