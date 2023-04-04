locals {
  rg_name   = azurerm_resource_group.ntierrg.name
  location  = azurerm_resource_group.ntierrg.location
  nsg_name  = azurerm_network_security_group.ntiernsg.name
  vnet_name = azurerm_virtual_network.ntiervnet.name
}