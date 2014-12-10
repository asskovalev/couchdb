
all:
	./rebar get-deps compile

app:
	@./rebar compile

clean:
	@./rebar clean
	@rm -f erl_crash.dump

shell:
	erl -pa apps/*/ebin -pa deps/*/ebin

run:
	ERL_LIBS=apps:deps erl -pa apps/*/ebin -pa deps/*/ebin -s couch_launcher

ct: test


package: tmproot
	cd tmproot && $(FPM) -f -t deb -n pulsedb -v $(VERSION) $(DEBIAN) -a amd64 --category net etc/init.d etc/pulsedb opt && cd ..
	mv tmproot/*.deb .
	@#cd tmproot && $(FPM) -f -t rpm -n pulsedb -v $(VERSION) $(DEBIAN) -a amd64 --gpg max@flussonic.com --category Server/Video etc/init.d etc/pulsedb opt && cd ..
	@#mv tmproot/*.rpm .
	rm -rf tmproot


test:
	mkdir -p logs
	ct_run -pa ebin -pa deps/*/ebin -logdir logs/ -dir test/

.PHONY: test tmproot

