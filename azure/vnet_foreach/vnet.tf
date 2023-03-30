resource "azurerm_resource_group" "ntierrg" {
  name     = var.resource_group_info.rg_name
  location = var.resource_group_info.location
}
resource "azurerm_virtual_network" "ntiervnet" {
  name                = var.vnet_info.vnet_name
  resource_group_name = azurerm_resource_group.ntierrg.name
  location            = azurerm_resource_group.ntierrg.location
  address_space       = var.vnet_info.address_space
  depends_on = [
    azurerm_resource_group.ntierrg
  ]
}
resource "azurerm_subnet" "ntiersubnets" {
  for_each             = var.subnets_info
  name                 = each.value.subnet_names
  address_prefixes     = each.value.address_prefixes
  virtual_network_name = azurerm_virtual_network.ntiervnet.name
  resource_group_name  = azurerm_resource_group.ntierrg.name

  depends_on = [
    azurerm_virtual_network.ntiervnet
  ]
}
