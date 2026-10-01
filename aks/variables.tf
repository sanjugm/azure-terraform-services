variable "location" { description = "Azure region" type = string default = "East US" }
variable "resource_group_name" { description = "Resource group name" type = string default = "rg-tf-aks-demo" }
variable "cluster_name" { description = "AKS cluster name" type = string }
variable "node_count" { description = "Number of nodes" type = number default = 2 }
variable "vm_size" { description = "AKS node VM size" type = string default = "Standard_D2s_v5" }
