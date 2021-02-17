#!/bin/bash
# Assumes image has been built as per ./build.sh
# Need to have nexus-vm set up in /etc/hosts

image_repo="nexus-vm:8082" # ip or host name (e.g. docker.io)
path_to_defaults="pipeline/nexus/config"

# Copy required configs and restart docker
sudo cp $path_to_defaults/docker /etc/default/docker
sudo cp $path_to_defaults/daemon.json /etc/docker/daemon.json
sudo systemctl restart docker

# Login to nexus repo
docker login -u admin -p password $image_repo
docker login -u admin -p password $image_repo

# Push docker image
docker push $image_repo/spring-petclinic-angular
