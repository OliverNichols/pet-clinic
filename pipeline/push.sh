#!/bin/bash
# Assumes image has been built as per ./build.sh
# Need to have nexus-vm set up in /etc/hosts

image_repo="nexus-vm:8082" # ip or host name (e.g. docker.io)

# Copy required configs and restart docker
sudo cp nexus/config/docker /etc/default/docker
sudo cp nexus/config/daemon.json /etc/docker/daemon.json
sudo systemctl restart docker

# Login to nexus repo
docker login -u admin -p password $image_repo
docker login -u admin -p password $image_repo

# Push docker image
docker push $image_repo/spring-petclinic-angular