data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "keyvault_rg" {
  name = var.resource_group_name
  location = var.location
}
resource "azurerm_key_vault" "key_vault" {
  name = var.key_vault_name
  location = var.location
  resource_group_name = var.resource_group_name
  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled = false
  rbac_authorization_enabled = true
}
resource "azurerm_role_assignment" "keyvault_role_assignment" {
  scope = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id = data.azurerm_client_config.current.object_id
}
