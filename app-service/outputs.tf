output "resource_group_name" { value = azurerm_resource_group.this.name }
output "app_service_plan_name" { value = azurerm_service_plan.this.name }
output "app_service_name" { value = azurerm_linux_web_app.this.name }
output "default_hostname" { value = azurerm_linux_web_app.this.default_hostname }
output "url" { value = "https://${azurerm_linux_web_app.this.default_hostname}" }
