SHELL:=/bin/bash
PROJECT_DIR:=$(shell pwd)

build:
	docker-compose -f docker-compose.result.yml build petstore

run:
	docker-compose -f docker-compose.result.yml up -d postgres
	docker-compose -f docker-compose.result.yml up petstore

clean:
	docker-compose -f docker-compose.result.yml down -v
