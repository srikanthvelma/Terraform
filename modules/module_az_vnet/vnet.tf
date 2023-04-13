module "az_vnet" {
    source = "./az_vnet"

    rg_info = {
      location = "East US"
      name = "az-rg"
    }
    vnet_info = {
      address_space = "192.168.0.0/16"
      name = "az-vnet"
    }
    
}