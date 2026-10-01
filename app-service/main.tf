terraform {
  required_version = ">= 1.6.0"
  required_providers { azurerm = { source = "hashicorp/azurerm", version = "~> 4.0" } }
}
provider "azurerm" { features {} }

resource "azurerm_resource_group" "this" {
  name = var.resource_group_name
  location = var.location
}
resource "azurerm_service_plan" "this" {
  name = "${var.app_name}-plan"
  location = var.location
  resource_group_name = var.resource_group_name
  os_type = "Linux"
  sku_name = var.sku_name
}
resource "azurerm_linux_web_app" "this" {
  name = var.app_name
  location = var.location
  resource_group_name = var.resource_group_name
  service_plan_id = azurerm_service_plan.this.id
  site_config {
    always_on = var.sku_name != "F1"
    application_stack { node_version = "20-lts" }
  }
}
