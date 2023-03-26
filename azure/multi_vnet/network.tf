resource "azurerm_resource_group" "vnetrg" {
  name     = var.resource_group_info.rg_name
  location = var.resource_group_info.location

}


resource "azurerm_virtual_network" "vnets" {
    count = length(var.virtual_network_info.vnet_names)
  name                = var.virtual_network_info.vnet_names[count.index]
  resource_group_name = azurerm_resource_group.vnetrg.name
  location            = azurerm_resource_group.vnetrg.location
  address_space       = [var.virtual_network_info.address_space[count.index]]

  depends_on = [
    azurerm_resource_group.vnetrg
  ]
}
resource "azurerm_subnet" "vnet1_subnet" {
  count                = length(var.virtual_network_info.subnet_names)
  name                 = var.virtual_network_info.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.vnetrg.name
  virtual_network_name = azurerm_virtual_network.vnets[0].name
  address_prefixes     = [cidrsubnet(var.virtual_network_info.address_space[0], 8, count.index)]


  depends_on = [
    azurerm_virtual_network.vnets
  ]
}
resource "azurerm_subnet" "vnet2_subnet" {
  count                = length(var.virtual_network_info.subnet_names)
  name                 = var.virtual_network_info.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.vnetrg.name
  virtual_network_name = azurerm_virtual_network.vnets[1].name
  address_prefixes     = [cidrsubnet(var.virtual_network_info.address_space[1], 8, count.index)]


  depends_on = [
    azurerm_virtual_network.vnets
  ]
}

