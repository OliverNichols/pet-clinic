#!/bin/bash

git_repo="https://github.com/pet-clinic-team-3/spring-petclinic-angular.git" # repo url for front-end

# Clone down repo
git clone $git_repo
cd spring-petclinic-angular

# Install apt dependencies
sudo apt update -y
sudo apt install npm -y
sudo apt install chromium-chromedriver -y
sudo apt install unzip wget -y

# Install npm dependencies
sudo npm install
sudo npm install -g @angular/cli@8
npm install --save-dev @angular/cli@8

# Install node.js v12
sudo npm install -g n
sudo n install v12.8.1

# Install terraform
wget https://releases.hashicorp.com/terraform/0.14.6/terraform_0.14.6_linux_amd64.zip
unzip terraform_*_linux_*.zip

sudo mv terraform /usr/local/bin/
rm terraform_*_linux_*.zip

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
sudo chmod +x kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo az aks install-cli

# Clean-up
# rm -rf spring-petclinic-angular
# rm -rf node_modules/ package-lock.json

# Install docker
docker --version || curl https://get.docker.com | sudo bash 
sudo usermod -aG docker $USER 