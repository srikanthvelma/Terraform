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
variable "virtual_network_info" {
  type = object({
    vnet_name     = string
    address_space = list(string)
    subnet_names  = list(string)
  })
  default = {
    address_space = ["192.168.0.0/16"]
    subnet_names  = ["web1", "app1", "db1"]
    vnet_name     = "ntiervnet"
  }
}

variable "sqlsrv_info" {
  type = object({
    sqlsrv_name                  = string
    administrator_login          = string
    administrator_login_password = string
    sqldb_name                   = string
    sku_name                     = string
  })
  default = {
    administrator_login          = "srikanthvelma"
    administrator_login_password = "Motherindia@123"
    sku_name                     = "Basic"
    sqldb_name                   = "employees"
    sqlsrv_name                  = "ntiersqlsrv"
  }
}
variable "vm_nic_info" {
  type = object({
    nic_name          = string
    nic_ip_name       = string
    nic_ip_allocation = string
    subnet_index      = number
  })
  default = {
    nic_name          = "websrvnic"
    nic_ip_name       = "websrvip"
    nic_ip_allocation = "Dynamic"
    subnet_index      = 0
  }
}

variable "vm_info" {
  type = object({
    vm_names    = list(string)
    vm_size     = string
    vm_username = string
  })
  default = {
    vm_names    = ["websrv1"]
    vm_size     = "Standard_B1s"
    vm_username = "srikanthvelma"
  }
}