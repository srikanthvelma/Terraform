variable "resource_group_info" {
  type = object({
    rg_name  = string
    location = string
  })
  default = {
    location = "East US"
    rg_name  = "vnetrg"
  }

}

variable "virtual_network_info" {
  type = object({
    vnet_names    = list(string)
    address_space = list(string)
    subnet_names  = list(string)
  })
  default = {
    vnet_names    = ["vnet1","vnet2"]
    address_space = ["192.168.0.0/16","10.0.0.0/16"]
    subnet_names  = ["subnet1","subnet2","subnet3","subnet4","subnet5","subnet6"]
  }
}

