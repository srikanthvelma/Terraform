variable "subnet_info" {
  type = object({
    subnet_name      = list(string)
    address_prefixes = list(string)
  })
  default = {
    subnet_name      = ["web1", "web2"]
    address_prefixes = ["192.168.0.0/24", "192.168.1.0/24"]
  }
}
variable "vm_nic_info" {
  type = object({
    nic_name       = list(string)
    nic_ip_name    = list(string)
    public_ip_name = list(string)
    nic_ip_allocation = string
    public_ip_allocation = string
  })
  default = {
    nic_name       = ["rednic", "greennic"]
    nic_ip_name    = ["redip", "greenip"]
    public_ip_name = ["redip", "greenip"]
    nic_ip_allocation = "Dynamic"
    public_ip_allocation = "Dynamic"
  }
}
variable "vm_info" {
  type = object({
    vm_name     = list(string)
    vm_size     = string
    vm_username = string
    vm_password = string
  })
  default = {
    vm_name     = ["redvm", "greenvm"]
    vm_size     = "Standard_B1s"
    vm_username = "srikanthvelma"
    vm_password = "Motherindia@123"
  }
}
