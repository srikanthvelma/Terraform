output "kube_config" {
  value = azurerm_kubernetes_cluster.azk8s.kube_config_raw
  sensitive = true
}