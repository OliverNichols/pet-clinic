#!/bin/bash

SERVICE_PRINCIPAL=$1
SERVICE_PRINCIPAL_SECRET=$2
TENANT_ID=$3
SUBSCRIPTION=$4

ssh-keygen -t rsa -b 4096 -N ""  -q -f  ~/.ssh/id_rsa
SSH_KEY=$(cat ~/.ssh/id_rsa.pub)

echo "Running terraform init"

terraform init

echo "Running terraform destroy"

terraform destroy -var serviceprinciple_id=$SERVICE_PRINCIPAL \
-var serviceprinciple_key="$SERVICE_PRINCIPAL_SECRET" \
-var tenant_id=$TENANT_ID \
-var subscription_id=$SUBSCRIPTION \
-var ssh_key="$SSH_KEY" \
-auto-approve

echo "Running terraform plan"

terraform plan -var serviceprinciple_id=$SERVICE_PRINCIPAL \
-var serviceprinciple_key="$SERVICE_PRINCIPAL_SECRET" \
-var tenant_id=$TENANT_ID \
-var subscription_id=$SUBSCRIPTION \
-var ssh_key="$SSH_KEY" \
-auto-approve

#echo "Running terraform import 1"
#
#terraform import -var serviceprinciple_id=$SERVICE_PRINCIPAL \
#-var serviceprinciple_key="$SERVICE_PRINCIPAL_SECRET" \
#-var tenant_id=$TENANT_ID \
#-var subscription_id=$SUBSCRIPTION \
#-var ssh_key="$SSH_KEY" \
#module.cluster.azurerm_resource_group.main /subscriptions/$SUBSCRIPTION/resourceGroups/petclinic-aks

#echo "Running terraform import 2"

#terraform import -var serviceprinciple_id=$SERVICE_PRINCIPAL \
#-var serviceprinciple_key="$SERVICE_PRINCIPAL_SECRET" \
#-var tenant_id=$TENANT_ID \
#-var subscription_id=$SUBSCRIPTION \
#-var ssh_key="$SSH_KEY" \
#module.cluster.azurerm_kubernetes_cluster.main /subscriptions/$SUBSCRIPTION/resourceGroups/petclinic-aks/providers/Microsoft.ContainerService/managedClusters/petclinic-aks

#echo "Running terraform apply"

#terraform apply -var serviceprinciple_id=$SERVICE_PRINCIPAL \
#-var serviceprinciple_key="$SERVICE_PRINCIPAL_SECRET" \
#-var tenant_id=$TENANT_ID \
#-var subscription_id=$SUBSCRIPTION \
#-var ssh_key="$SSH_KEY" \
#-auto-approve

echo "Running aks"

az aks get-credentials -n petclinic-aks -g petclinic-aks --overwrite-existing

