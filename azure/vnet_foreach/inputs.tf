variable "resource_group_info" {
  type = object({
    rg_name  = string
    location = string
  })
  default = {
    location = "East US"
    rg_name  = "ntierrg"
  }
}
variable "vnet_info" {
  type = object({
    vnet_name     = string
    address_space = list(string)
  })
  default = {
    address_space = ["192.168.0.0/16"]
    vnet_name     = "ntiervnet"
  }

}
variable "subnets_info" {
  type = map(object({
    address_prefixes = list(string)
    subnet_names     = string
  }))
  default = {
    "subnet1" = {
      address_prefixes = ["192.168.0.0/24"]
      subnet_names     = "web1"
    },
    "subnet2" = {
      address_prefixes = ["192.168.1.0/24"]
      subnet_names     = "app1"
    }
  }
}
variable "nics_info" {
  type = map(object({
    ip_name = string

  }))
  default = {
    "nic1" = {
      ip_name = "nic1_ip"
    }
    "nic2" = {
      ip_name = "nic2_ip"
    }
  }
  
}
