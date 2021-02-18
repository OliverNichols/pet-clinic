resource "azurerm_resource_group" "main" {
  name     = "petclinic-aks"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "main" {
  name                  = "petclinic-aks"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  dns_prefix            = "petclinic-aks-212"            
  kubernetes_version    =  var.kubernetes_version
  
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = var.vm_size
    type       = "VirtualMachineScaleSets"
    os_disk_size_gb = 50
  }

  service_principal  {
    client_id = var.serviceprinciple_id
    client_secret = var.serviceprinciple_key
  }

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
        key_data = var.ssh_key
    }
  }

  network_profile {
      network_plugin = "kubenet"
      load_balancer_sku = "Standard"
  }

  addon_profile {
    aci_connector_linux {
      enabled = false
    }

    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    kube_dashboard {
      enabled = false
    }

    oms_agent {
      enabled = false
    }
  }

}