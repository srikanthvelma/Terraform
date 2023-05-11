locals {
  rg_name   = azurerm_resource_group.tfrg.name
  location  = azurerm_resource_group.tfrg.location
  nsg_name  = azurerm_network_security_group.tfnsg.name
  vnet_name = azurerm_virtual_network.tfvnet.name
}