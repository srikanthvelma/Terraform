resource "azurerm_resource_group" "azrg" {
    name = "az-rg"
    location = "East US"
    
  
}
resource "azurerm_resource_group" "azrg2" {
    name = "az-rg2"
    location = "East US 2"
  
}

module "vnet1" {
  source  = "Azure/vnet/azurerm"
  version = "4.0.0"
  
  resource_group_name = "az-rg"
  vnet_location       = "East US"
  vnet_name           = "az-vnet1"
  use_for_each = false

  depends_on = [
    azurerm_resource_group.azrg
  ]
}

module "vnet2" {
  source  = "Azure/vnet/azurerm"
  version = "4.0.0"


  resource_group_name = "az-rg2"
  vnet_location       = "East US 2"
  vnet_name           = "az-vnet2"
  use_for_each = false
  depends_on = [
    azurerm_resource_group.azrg2
  ]
}