variable "rg_info" {
    type = object({
        name = string
        location = string
    })
    default = {
      location = "East US"
      name = "az-rg"
    } 
}
variable "vnet_info" {
    type = object({
        name = string
        address_space = string
    })
    default = {
      address_space = "192.168.0.0/16"
      name = "az-vnet"
    } 
}