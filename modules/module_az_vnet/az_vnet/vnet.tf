resource "azurerm_resource_group" "azrg" {
    name = var.rg_info.name
    location = var.rg_info.location 
}
resource "azurerm_virtual_network" "azvnet" {
    name = var.vnet_info.name
    resource_group_name = azurerm_resource_group.azrg.name
    location = azurerm_resource_group.azrg.location
    address_space = var.vnet_info.address_space
}