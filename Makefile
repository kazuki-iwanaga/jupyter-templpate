SHELL=bash

CONTAINER_NAME=notebook

.PHONY=up
up:
	if [ ! -e .env ]; then touch .env; fi
	docker compose run --rm \
		-v $(CURDIR)/.env:/tmp/.env \
		-v $(CURDIR)/passworder.py:/tmp/passworder.py \
		notebook python /tmp/passworder.py
	docker compose up -d
	make url
	make open

.PHONY=down
down:
	docker compose down
	mv .env /tmp/env-from-jupyter-template

.PHONY=url
url:
	@echo ' ----------------------------'
	@echo "|                            |"
	@echo "|  http://localhost:`grep 'JUPYTER_PORT' .env | sed -e 's/JUPYTER_PORT=//'`    |"
	@echo "|                            |"
	@echo ' ----------------------------'

.PHONY=open
open:
	open http://localhost:`grep 'JUPYTER_PORT' .env | sed -e 's/JUPYTER_PORT=//'`

.PHONY=ps
ps:
	docker compose ps

.PHONY=log
log:
	docker compose logs notebook

.PHONY=in
in:
	docker compose exec notebook /bin/bash