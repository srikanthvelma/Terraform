resource "azurerm_resource_group" "ntierrg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "ntiervnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space

  depends_on = [
    azurerm_resource_group.ntierrg
  ]
}

resource "azurerm_subnet" "subnets" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, count.index)]
  depends_on = [
    azurerm_virtual_network.ntiervnet
  ]

}
