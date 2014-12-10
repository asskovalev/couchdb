-module(couch_index_merger_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    couch_index_merger_sup:start_link().

stop(_State) ->
    ok.
