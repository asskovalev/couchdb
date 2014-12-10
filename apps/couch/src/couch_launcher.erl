-module(couch_launcher).
-export([start/0]).

start() ->
lager:start(),
  ok = couch:start(),
  % ok = couch_server_sup:start_link([]),
  ok = couch_config:set("couchdb", "database_dir", "dbs"),
  % couch_doc:from_binary(<<"1">>, <<"{\"a\":\"asshole\"}">>, true).
  ok.