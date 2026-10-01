output "resource_group_name" { value = azurerm_resource_group.aks_rg.name }
output "cluster_name" { value = azurerm_kubernetes_cluster.aks_cluster.name }
output "kube_config_command" { value = "az aks get-credentials --resource-group ${azurerm_resource_group.aks_rg.name} --name ${azurerm_kubernetes_cluster.aks_cluster.name}" }
