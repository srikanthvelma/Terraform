variable "narmada" {
  type = object({
    name     = string
    location = string
    tags     = string
  })
  default = {
    name     = "ab-resource"
    location = "East Us"
    tags     = "dev"
  }
}
variable "vnet" {
  type = object({
    name          = string
    address_space = list(string)
    tags          = string
  })
  default = {
    name          = "ab_vnet"
    address_space = ["10.0.0.0/16"]
    tags          = "dev"
  }
}
variable "subnets" {
  type = object({
    name             = string
    address_prefixes = list(string)
  })
  default = {
    name             = "web"
    address_prefixes = ["10.0.1.0/24"]
  }

}
variable "pubip" {
  type = object({
    name              = string
    allocation_method = string
    tags              = string
  })
  default = {
    name              = "ab_pub"
    allocation_method = "Static"
    tags              = "dev"
  }
}
variable "vms" {
  type    = number
  default = 2
}

variable "vm_info" {
  type = object({
    name           = string
    size           = string
    admin_username = string
  })
  default = {
    name           = "vm1"
    size           = "Standard_B1ms"
    admin_username = "Narmadavendi"
  }
}
variable "source_image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}
variable "lbpub" {
  type = object({
    name              = string
    allocation_method = string
  })
  default = {
    name              = "lbpubip"
    allocation_method = "Static"
  }

}

variable "az_location" {
  type    = list(string)
  default = ["eastus", "eastus2"]
}