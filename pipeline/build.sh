#!/bin/bash
# Requires "curl https://get.docker.com | sudo bash && sudo usermod -aG docker $USER && newgrp docker" to be run

image_repo="nexus-vm:8082" # ip or host name (e.g. docker.io)
git_repo="https://github.com/OliverNichols/spring-petclinic-angular.git" # repo url for front-end

# Install apt dependencies
sudo apt install npm -y

# Install npm dependencies
sudo npm uninstall -g angular-cli @angular/cli
sudo npm cache clean
sudo npm install -g @angular/cli@latest

npm install --save-dev @angular/cli@latest

# Clone down repo
git clone $git_repo

# Build docker image
docker build -t $image_repo/spring-petclinic-angular spring-petclinic-angular

# Clean-up
rm -rf spring-petclinic-angular
rm -rf node_modules/ package-lock.json