#!/bin/bash
# Example usage - `bash ./push.sh -r docker.io/user -u user -p pass`

# Environment variables with flag -r (image repo), -u (username, required), -p (password, required)
while getopts r:u:p: opt; do case "${opt}" in
r) image_repo=${OPTARG};;
u) image_repo_usr=${OPTARG};; # required
p) image_repo_psw=${OPTARG} # required
esac done

# Default values
if [ -z $image_repo ]; then image_repo='docker.io/ollienichols'; fi
path_to_defaults="pet-clinic/pipeline/nexus/config"

# Login to image repo
docker login -u $image_repo_usr -p $image_repo_psw $image_repo

# Build docker image
docker build -t $image_repo/spring-petclinic-angular .

# Push docker image
docker push $image_repo/spring-petclinic-angular
