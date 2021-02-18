#!/bin/bash

SERVICE_PRINCIPAL=$1
SERVICE_PRINCIPAL_SECRET=$2
TENANT_ID=$3
SUBSCRIPTION=$4

ssh-keygen -t rsa -b 4096 -N ""  -q -f  ~/.ssh/id_rsa
SSH_KEY=$(cat ~/.ssh/id_rsa.pub)

terraform init

terraform plan -var serviceprinciple_id=$SERVICE_PRINCIPAL \
-var serviceprinciple_key="$SERVICE_PRINCIPAL_SECRET" \
-var tenant_id=$TENANT_ID \
-var subscription_id=$SUBSCRIPTION \
-var ssh_key="$SSH_KEY" \
-auto-approve

terraform import azurerm_resource_group.main /subscriptions/$SUBSCRIPTION/resourceGroups/petclinic-aks

terraform apply -var serviceprinciple_id=$SERVICE_PRINCIPAL \
-var serviceprinciple_key="$SERVICE_PRINCIPAL_SECRET" \
-var tenant_id=$TENANT_ID \
-var subscription_id=$SUBSCRIPTION \
-var ssh_key="$SSH_KEY" \
-auto-approve

az aks get-credentials -n petclinic-aks -g petclinic-aks --overwrite-existing

