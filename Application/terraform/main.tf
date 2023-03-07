terraform {
  required_version = ">= 0.13.4"
  backend "azurerm" {
  }
}

provider "azurerm" {
  version = "3.18.0"
  skip_provider_registration = "false" 
  features {}
}

##############################
######## Azure modules #######
##############################

# Generate random resource group name
resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

resource "azurerm_kubernetes_cluster" "k8s" {
  location            = azurerm_resource_group.rg.location
  name                = var.cluster_name
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix
  tags                = {
    Environment = "dev"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.agent_count
  }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
  service_principal {
    client_secret = var.aks_service_principal_client_secret
    client_id     = var.aks_service_principal_app_id
  }
}