resource "azurerm_resource_group" "vnetrg" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_virtual_network" "vnet1" {
  name                = var.virtual_network_name
  resource_group_name = azurerm_resource_group.vnetrg.name
  location            = azurerm_resource_group.vnetrg.location
  address_space       = var.address_space

  depends_on = [
    azurerm_resource_group.vnetrg
  ]
}

resource "azurerm_subnet" "subnets" {
  count                = length(var.subnets)
  name                 = var.subnets[count.index]
  resource_group_name  = azurerm_resource_group.vnetrg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, count.index)]

  depends_on = [
    azurerm_virtual_network.vnet1
  ]
}

