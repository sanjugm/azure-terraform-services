terraform {
  required_version = ">= 1.6.0"
  required_providers { azurerm = { source = "hashicorp/azurerm", version = "~> 4.0" } }
}
provider "azurerm" { features {} }

data "azurerm_client_config" "current" {}
variable "location" { type = string default = "East US" }
variable "resource_group_name" { type = string default = "rg-tf-keyvault-demo" }
variable "key_vault_name" { type = string }

resource "azurerm_resource_group" "this" { name = var.resource_group_name location = var.location }
resource "azurerm_key_vault" "this" {
  name = var.key_vault_name location = var.location resource_group_name = var.resource_group_name
  tenant_id = data.azurerm_client_config.current.tenant_id sku_name = "standard"
  soft_delete_retention_days = 7 purge_protection_enabled = false rbac_authorization_enabled = true
}
resource "azurerm_role_assignment" "current_user" {
  scope = azurerm_key_vault.this.id role_definition_name = "Key Vault Administrator" principal_id = data.azurerm_client_config.current.object_id
}
output "key_vault_name" { value = azurerm_key_vault.this.name }
output "key_vault_uri" { value = azurerm_key_vault.this.vault_uri }
