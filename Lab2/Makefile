SHELL:=/bin/bash
PROJECT_DIR:=$(shell pwd)

build:
	docker image build -f Dockerfile.result -t aws-workshops/petstore:latest .

run:
	docker container run --rm --name=petstore -p 8080:8080 -p 9990:9990 aws-workshops/petstore:latest

clean:
	docker image rm aws/petstore:latest
	docker image rm maven:3.5-jdk-7
	docker image rm jboss/wildfly:11.0.0.Final
