#!/bin/bash
# Assumes image has been built as per ./build.sh

image_repo="nexus-vm:8082" # ip or host name (e.g. docker.io)

image_repo_user="admin"
image_repo_pass="password"

path_to_defaults="pet-clinic/pipeline/nexus/config"

# Copy required configs and restart docker
sudo cp $path_to_defaults/docker /etc/default/docker
sudo cp $path_to_defaults/daemon.json /etc/docker/daemon.json
sudo systemctl restart docker

# Login to image repo
docker login -u $image_repo_user -p $image_repo_pass $image_repo

# Push docker image
docker push $image_repo/spring-petclinic-angular
