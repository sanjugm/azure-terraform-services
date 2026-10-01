terraform {
  required_version = ">= 1.6.0"
  required_providers { azurerm = { source = "hashicorp/azurerm", version = "~> 4.0" } }
}
provider "azurerm" { features {} }

variable "location" { type = string default = "East US" }
variable "resource_group_name" { type = string default = "rg-tf-aks-demo" }
variable "cluster_name" { type = string }
variable "node_count" { type = number default = 2 }
variable "vm_size" { type = string default = "Standard_D2s_v5" }

resource "azurerm_resource_group" "this" { name = var.resource_group_name location = var.location }
resource "azurerm_virtual_network" "this" { name = "${var.cluster_name}-vnet" location = var.location resource_group_name = var.resource_group_name address_space = ["10.20.0.0/16"] }
resource "azurerm_subnet" "aks" { name = "aks-subnet" resource_group_name = var.resource_group_name virtual_network_name = azurerm_virtual_network.this.name address_prefixes = ["10.20.0.0/20"] }
resource "azurerm_kubernetes_cluster" "this" {
  name = var.cluster_name location = var.location resource_group_name = var.resource_group_name dns_prefix = var.cluster_name
  default_node_pool { name = "system" node_count = var.node_count vm_size = var.vm_size vnet_subnet_id = azurerm_subnet.aks.id }
  identity { type = "SystemAssigned" }
  network_profile { network_plugin = "azure" network_plugin_mode = "overlay" network_policy = "azure" service_cidr = "10.30.0.0/16" dns_service_ip = "10.30.0.10" }
  role_based_access_control_enabled = true
}
output "cluster_name" { value = azurerm_kubernetes_cluster.this.name }
output "resource_group_name" { value = azurerm_resource_group.this.name }
output "kube_config_command" { value = "az aks get-credentials --resource-group ${azurerm_resource_group.this.name} --name ${azurerm_kubernetes_cluster.this.name}" }
