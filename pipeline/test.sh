sudo apt update
curl https://get.docker.com | sudo bash
sudo usermod -aG docker $(whoami)
newgrp docker
sudo apt install npm -y
sudo npm install -g @angular/cli@8.0.3 -y
git clone https://github.com/spring-petclinic/spring-petclinic-angular.git
cd spring-petclinic-angular
npm install --save-dev @angular/cli@8.0.3 -y
sudo npm install
docker run -d -p 9966:9966 springcommunity/spring-petclinic-rest
sudo npm install -g n
sudo n install v12.8.1
PATH="$PATH"


ng build
npm run test-headless
