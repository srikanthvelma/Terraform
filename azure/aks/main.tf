resource "azurerm_resource_group" "aksrg" {
  name     = "aksrg"
  location = "East Us"
}
resource "azurerm_kubernetes_cluster" "azk8s" {
  name                = "nop-aks"
  location            = azurerm_resource_group.aksrg.location
  resource_group_name = azurerm_resource_group.aksrg.name
  dns_prefix          = "nop-aks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    ENV = "Dev"
  }
}
