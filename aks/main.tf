resource "azurerm_resource_group" "sanju" {
  name = var.resource_group_name
  location = var.location
}
resource "azurerm_virtual_network" "sanju_vnet" {
  name = "${var.cluster_name}-vnet"
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = ["10.20.0.0/16"]
}
resource "azurerm_subnet" "aks" {
  name = "aks-subnet"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes = ["10.20.0.0/20"]
}
resource "azurerm_kubernetes_cluster" "sanju" {
  name = var.cluster_name
  location = var.location
  resource_group_name = var.resource_group_name
  dns_prefix = var.cluster_name

  default_node_pool {
    name = "system"
    node_count = var.node_count
    vm_size = var.vm_size
    vnet_subnet_id = azurerm_subnet.aks.id
  }

  identity { type = "SystemAssigned" }

  network_profile {
    network_plugin = "azure"
    network_plugin_mode = "overlay"
    network_policy = "azure"
    service_cidr = "10.30.0.0/16"
    dns_service_ip = "10.30.0.10"
  }

  role_based_access_control_enabled = true
}
