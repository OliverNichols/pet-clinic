#!/bin/bash
sudo apt update
sudo apt install chromium-chromedriver -y
export CHROME_BIN=/usr/bin/chromium-browser
sudo apt install npm -y
sudo npm install -g @angular/cli@8
git clone https://github.com/OliverNichols/spring-petclinic-angular
cd spring-petclinic-angular
npm install --save-dev @angular/cli@8
sudo npm install
sudo npm install -g n
sudo n install v12.8.1
PATH="$PATH"


ng build
npm run test-headless
