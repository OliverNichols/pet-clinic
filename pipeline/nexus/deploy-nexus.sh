#!/bin/bash
# Requires "curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash && az login" to be run and authenticated

# Base variables
group_name=pet-clinic-nexus-rg
admin_username=nexus_admin
vm_name=nexus

# Create resource group
az group create -n $group_name -l uksouth

# Create new VM
az vm create -n $vm_name -g $group_name --size Standard_B1ms --image UbuntuLTS --admin-username $admin_username -l uksouth --generate-ssh-keys

# Open port 8081-83
az vm open-port -n $vm_name -g $group_name --port 8081 --priority 1001
az vm open-port -n $vm_name -g $group_name --port 8082 --priority 1002
az vm open-port -n $vm_name -g $group_name --port 8083 --priority 1003

# Custom script - doesn't seem to work
# az vm extension set --vm-name $vm_name -g $group_name -n run_nexus --publish Microsoft.Azure.Extensions --protected-settings '{ "script": "$(cat install-nexus.sh | gzip -9 | base64 -w0)" }' # doesn't work as expected, needs to be run manually at the moment

# Show IP
public_ip="$(az vm show -d -g $group_name -n $vm_name --query publicIps -o tsv)"

# Add entry for nexus-vm to hosts
grep -qxF "$public_ip nexus-vm" /etc/hosts || echo "$public_ip nexus-vm" | sudo tee -a /etc/hosts
echo "$public_ip nexus-vm"