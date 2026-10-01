variable "location" { description = "Azure region" type = string default = "East US" }
variable "resource_group_name" { description = "Resource group name" type = string default = "rg-tf-vm-demo" }
variable "vm_name" { description = "Virtual machine name" type = string default = "tf-vm-demo" }
variable "admin_username" { description = "Linux VM administrator username" type = string default = "azureuser" }
variable "admin_password" { description = "Linux VM administrator password" type = string sensitive = true }
variable "ssh_public_key" { description = "SSH public key" type = string default = "" }
