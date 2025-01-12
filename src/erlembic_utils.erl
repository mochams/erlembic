-module(erlembic_utils).

-export([extract_arg_value/2, project_root/0]).

extract_arg_value(Args, ArgName) ->
    ArgValue = proplists:get_value(ArgName, Args),
    case ArgValue of
        undefined -> rebar_api:abort("~s was not provided: ~p", [ArgName, ArgValue]);
        _ -> ArgValue
    end.

project_root() ->
    {_, Path} = file:get_cwd(),
    Path.
