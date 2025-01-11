-module(rebar3_erlembic_utils).

-export([extract_arg_value/2]).

extract_arg_value(Args, ArgName) ->
    ArgValue = proplists:get_value(ArgName, Args),
    case ArgValue of
        undefined -> rebar_api:abort("~s was not provided: ~p", [ArgName, ArgValue]);
        _ -> ArgValue
    end.
