#!/bin/bash
# Requires ./dependencies.sh to be run

cd spring-petclinic-angular

image_repo="nexus-vm:8082" # ip or host name (e.g. docker.io)

# Build docker image
docker build -t $image_repo/spring-petclinic-angular spring-petclinic-angular
