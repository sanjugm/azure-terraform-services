resource "azurerm_resource_group" "storage_rg" {
  name = var.resource_group_name
  location = var.location
}
resource "azurerm_storage_account" "storage_account" {
  name = var.storage_account_name
  resource_group_name = var.resource_group_name
  location = var.location
  account_tier = "Standard"
  account_replication_type = "LRS"
  min_tls_version = "TLS1_2"
  allow_nested_items_to_be_public = false
  blob_properties { versioning_enabled = true }
}
resource "azurerm_storage_container" "storage_container" {
  name = var.container_name
  storage_account_id = azurerm_storage_account.storage_account.id
  container_access_type = "private"
}
