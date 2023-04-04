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
data "azurerm_subnet" "subnet1" {
  name                 = var.subnets_info.subnet2.subnet_names
  virtual_network_name = azurerm_resource_group.ntierrg.name
  resource_group_name  = azurerm_resource_group.ntierrg.location
}

output "subnet_id" {
  value = data.azurerm_subnet.subnet1
}
resource "azurerm_network_interface" "ntier-nics" {
  for_each = var.nics_info
  name                = each.key
  resource_group_name = azurerm_resource_group.ntierrg.name
  location            = azurerm_resource_group.ntierrg.location
  ip_configuration {
    name      = each.value.ip_name
    subnet_id = data.azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"

  }
}