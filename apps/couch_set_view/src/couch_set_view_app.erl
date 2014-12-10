-module(couch_set_view_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    couch_set_view_sup:start_link().

stop(_State) ->
    ok.
