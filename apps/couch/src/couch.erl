% Licensed under the Apache License, Version 2.0 (the "License"); you may not
% use this file except in compliance with the License. You may obtain a copy of
% the License at
%
%   http://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
% WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
% License for the specific language governing permissions and limitations under
% the License.

-module(couch).

-compile(export_all).

start() ->
    application:start(couch).

stop() ->
    application:stop(couch).

restart() ->
    case stop() of
    ok ->
        start();
    {error, {not_started,couch}} ->
        start();
    {error, Reason} ->
        {error, Reason}
    end.

reload() ->
    case supervisor:terminate_child(couch_server_sup, couch_config) of
    ok ->
        supervisor:restart_child(couch_server_sup, couch_config);
    {error, Reason} ->
        {error, Reason}
    end.

store(Db, Obj) when is_list(Obj) ->
    Id = couch_uuids:new(),
    store(Db, Id, Obj).

store(Db, Id, Obj) when is_list(Obj) ->
    Doc = couch_doc:from_json_obj({[
        {<<"meta">>, {[{<<"id">>,Id}]}},
        {<<"json">>, {Obj}}]}),
    case couch_db_frontend:update_doc(Db, Doc, []) of
        ok -> {ok, Id};
        Other -> Other
    end.

lookup(Db, Id) ->
    couch_db_frontend:open_doc(Db, Id, [ejson_body]).

update(Db, Id, Obj) ->
    error.