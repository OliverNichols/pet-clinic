#!/bin/bash
# To be run on Nexus host VM

curl https://get.docker.com | sudo bash
sudo usermod -aG docker $USER
newgrp docker

docker run -d -p 8081:8081 -p 8082:8082 -p 8083:8083 --name nexus sonatype/nexus3
admin_password="$(docker exec nexus cat nexus-data/admin.password)"

echo $admin_password