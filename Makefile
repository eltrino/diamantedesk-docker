TAG=eltrino/diamante_desk
ID_FILE=docker_container.id
ID_DB_FILE=docker_db_container.id
DB_CONTAINER_NAME=mysql56_diamante
MYSQL_ROOT_PASSWORD=123123
MYSQL_DATABASE=diamantedesk
MYSQL_USER=diamantedesk
MYSQL_PASSWORD=123123

build:
	docker build -t $(TAG) .

run:
ifneq ("$(wildcard $(ID_FILE))", "")
	docker start `cat $(ID_FILE)`
else
	echo `docker run --name diamante -d -p 80:80 -p 8080:8080 --link $(DB_CONTAINER_NAME):db $(TAG)` > $(ID_FILE)
endif

login: run
	docker exec -it `cat $(ID_FILE)` bash

stop:
	docker stop `cat $(ID_FILE)`

delete:
	docker rm `cat $(ID_FILE)`
	rm -f $(ID_FILE)

kill: stop delete

rundb:
ifneq ("$(wildcard $(ID_DB_FILE))", "")
	docker start `cat $(ID_DB_FILE)`
else
	echo `docker run --name $(DB_CONTAINER_NAME) -e MYSQL_ROOT_PASSWORD=$(MYSQL_ROOT_PASSWORD) -e MYSQL_DATABASE=$(MYSQL_DATABASE) -e MYSQL_USER=$(MYSQL_USER) -e MYSQL_PASSWORD=$(MYSQL_PASSWORD) -d mysql:5.6` > $(ID_DB_FILE)
endif

logindb: rundb
	docker exec -it `cat $(ID_DB_FILE)` bash

stopdb:
	docker stop `cat $(ID_DB_FILE)`

deletedb:
	docker rm `cat $(ID_DB_FILE)`
	rm -f $(ID_DB_FILE)

killdb: stopdb deletedb

runall: rundb run

stopall: stop stopdb

killall: kill killdb