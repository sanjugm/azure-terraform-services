output "resource_group_name" { value = azurerm_resource_group.appservice_rg.name }
output "app_service_plan_name" { value = azurerm_service_plan.app_service_plan.name }
output "app_service_name" { value = azurerm_linux_web_app.linux_web_app.name }
output "default_hostname" { value = azurerm_linux_web_app.linux_web_app.default_hostname }
output "url" { value = "https://${azurerm_linux_web_app.linux_web_app.default_hostname}" }
