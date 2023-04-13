resource "azurerm_resource_group" "azimprg" {
  name     = "terraform"
  location = "East US"

}
resource "azurerm_virtual_network" "azimpvnet" {
  name                = "az-vnet"
  resource_group_name = "terraform"
  address_space = ["10.0.0.0/16"]
  location = "East US"

}
resource "azurerm_subnet" "azimpsubnet1" {
  name                 = "az-sub1"
  virtual_network_name = "az-vnet"
  resource_group_name = "terraform"
  address_prefixes = ["10.0.0.0/24"]

}
resource "azurerm_subnet" "azsub5" {
  name                 = "az-sub5"
  address_prefixes     = ["10.0.4.0/24"]
  virtual_network_name = azurerm_virtual_network.azimpvnet.name
  resource_group_name  = azurerm_resource_group.azimprg.name

}
resource "azurerm_subnet" "azimpsubnets" {
    count = 3
    name                 = var.subnet_info.name[count.index]
    virtual_network_name = "az-vnet"
    resource_group_name = "terraform"
    address_prefixes = var.subnet_info.address_prefixes[count.index]
}