
-module(fprofx_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

-export([init/1]).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    fprofx:start().

init(_)-> 
    {ok,[]}.
