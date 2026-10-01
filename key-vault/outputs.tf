output "resource_group_name" { value = azurerm_resource_group.keyvault_rg.name }
output "key_vault_name" { value = azurerm_key_vault.key_vault.name }
output "key_vault_uri" { value = azurerm_key_vault.key_vault.vault_uri }
