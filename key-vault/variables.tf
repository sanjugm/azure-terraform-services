variable "location" { description = "Azure region" type = string default = "East US" }
variable "resource_group_name" { description = "Resource group name" type = string default = "rg-tf-keyvault-demo" }
variable "key_vault_name" { description = "Globally unique Key Vault name" type = string }
