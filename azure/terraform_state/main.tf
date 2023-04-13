resource "azurerm_resource_group" "rg" {
  name     = "rg"
  location = "East US"
}
resource "azurerm_virtual_network" "azvnet" {
  name                = "az-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["192.168.0.0/16"]
  location            = azurerm_resource_group.rg.location
}
resource "azurerm_subnet" "web" {
  name                 = "one"
  address_prefixes     = ["192.168.0.0/24"]
  virtual_network_name = azurerm_virtual_network.azvnet.name
  resource_group_name  = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "app" {
  name                 = "two"
  address_prefixes     = ["192.168.1.0/24"]
  virtual_network_name = azurerm_virtual_network.azvnet.name
  resource_group_name  = azurerm_resource_group.rg.name
}
resource "azurerm_subnet" "db" {
  name                 = "db"
  address_prefixes     = ["192.168.2.0/24"]
  virtual_network_name = azurerm_virtual_network.azvnet.name
  resource_group_name  = azurerm_resource_group.rg.name
}