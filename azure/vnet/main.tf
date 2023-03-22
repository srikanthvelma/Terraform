provider "azurerm" {
  features {}

}

resource "azurerm_resource_group" "vnet" {
  name     = "vnetgroup"
  location = "East US"

}

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  resource_group_name = "vnetgroup"
  location            = "East US"
  address_space       = ["192.168.0.0/16"]

  subnet {
    address_prefix = "192.168.1.0/24"
    name           = "appsubnet"
  }
  
  depends_on = [
    azurerm_resource_group.vnet
  ]
}