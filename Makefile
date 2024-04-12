ARGS = $(filter-out $@,$(MAKECMDGOALS))
%:
	@:

start:
	rm -rf tmp/pids/server.pid
	bin/rails s -b '0.0.0.0' -p 5555

test:
	bundle exec rspec $(ARGS)

lint:
	bundle exec rubocop

lint-fix:
	bundle exec rubocop -A

gen-doc:
	rake rswag

dc-test:
	docker compose run --rm web bundle exec rspec $(ARGS)

.PHONY: test
