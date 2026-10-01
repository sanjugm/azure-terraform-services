output "resource_group_name" { value = azurerm_resource_group.vm_rg.name }
output "vm_name" { value = azurerm_linux_virtual_machine.linux_vm.name }
output "public_ip_address" { value = azurerm_public_ip.vm_public_ip.ip_address }
output "ssh_command" { value = "ssh ${var.admin_username}@${azurerm_public_ip.vm_public_ip.ip_address}" }
