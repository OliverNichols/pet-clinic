
TENANT_ID=6b40b30e-9dd5-487f-8598-c03d910bc6f5


SUBSCRIPTION=5f25ab28-b660-41e9-86b4-15dd16737c75
az account set --subscription $SUBSCRIPTION

ssh-keygen -t rsa -b 4096 -N ""  -q -f  ~/.ssh/id_rsa
SSH_KEY=$(cat ~/.ssh/id_rsa.pub)


SERVICE_PRINCIPAL_JSON=$(az ad sp create-for-rbac --skip-assignment --name petclinic-aks-sp -o json)

# Keep the `appId` and `password` for later use!

SERVICE_PRINCIPAL=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
SERVICE_PRINCIPAL_SECRET=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')


# Grant contributor role over the subscription to our service principal

az role assignment create --assignee $SERVICE_PRINCIPAL \
--scope "/subscriptions/$SUBSCRIPTION" \
--role Contributor

terraform init

terraform plan -var serviceprinciple_id=$SERVICE_PRINCIPAL \
-var serviceprinciple_key="$SERVICE_PRINCIPAL_SECRET" \
-var tenant_id=$TENANT_ID \
-var subscription_id=$SUBSCRIPTION \
-var ssh_key="$SSH_KEY" <<-EOF
yes
EOF



terraform apply -var serviceprinciple_id=$SERVICE_PRINCIPAL \
-var serviceprinciple_key="$SERVICE_PRINCIPAL_SECRET" \
-var tenant_id=$TENANT_ID \
-var subscription_id=$SUBSCRIPTION \
-var ssh_key="$SSH_KEY" <<-EOF
yes
EOF

az aks get-credentials -n petclinic-aks -g petclinic-aks


terraform destroy -var serviceprinciple_id=$SERVICE_PRINCIPAL \
-var serviceprinciple_key="$SERVICE_PRINCIPAL_SECRET" \
-var tenant_id=$TENANT_ID \
-var subscription_id=$SUBSCRIPTION \
-var ssh_key="$SSH_KEY" <<-EOF
yes
EOF
