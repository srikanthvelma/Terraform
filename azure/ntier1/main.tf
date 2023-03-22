resource "azurerm_resource_group" "ntierrg" {
  name     = "ntierrg"
  location = "East US"
}

resource "azurerm_virtual_network" "ntiervnet" {
  name                = "ntiervnet"
  resource_group_name = "ntierrg"
  location            = "East US"
  address_space       = ["192.168.0.0/16"]

  subnet {
    name           = "app1"
    address_prefix = "192.168.0.0/24"
  }

  subnet {
    name           = "app2"
    address_prefix = "192.168.1.0/24"
  }

  subnet {
    name           = "db1"
    address_prefix = "192.168.2.0/24"
  }

  subnet {
    name           = "db2"
    address_prefix = "192.168.3.0/24"
  }
  depends_on = [
    azurerm_resource_group.ntierrg
  ]
}