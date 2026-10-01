output "resource_group_name" { value = azurerm_resource_group.storage_rg.name }
output "storage_account_name" { value = azurerm_storage_account.storage_account.name }
output "primary_blob_endpoint" { value = azurerm_storage_account.storage_account.primary_blob_endpoint }
output "container_name" { value = azurerm_storage_container.storage_container.name }
