ifeq ($(LOCAL_UID),)
export LOCAL_UID = $(shell id -u)
endif

ifeq ($(COMPOSE_PROJECT_NAME),)
export COMPOSE_PROJECT_NAME = volops
endif

build:
	docker-compose -f docker-compose.yml build
	docker-compose run web rails db:create db:migrate

run-dev:
	rm -f tmp/pids/server.pid > /dev/null 2>&1
	docker-compose -f docker-compose.yml up

bundleinstall:
	docker-compose run web bundle install

run-dev-detached:
	docker-compose -f docker/docker-compose.yml up -d

makemigrations:
	docker-compose run web bundle install
	docker-compose run web rails db:migrate

docker-kill-all:
	docker-compose -f docker/docker-compose.yml kill

docker-rm-all:
	docker-compose -f docker/docker-compose.yml rm -v -f

clean:
	[ -f ./Gemfile.lock ]
	docker system prune -f
	docker volume prune -f
	docker-compose -f docker-compose.yml rm -sf
	docker-compose -f docker-compose.yml build

clean-db:
	 @echo 'Removing database data volume'
	 docker volume rm $(COMPOSE_PROJECT_NAME)_pgdata
