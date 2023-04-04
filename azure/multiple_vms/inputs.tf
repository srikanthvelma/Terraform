variable "rg_info" {
  type = object({
    name     = string
    location = string
  })
  default = {
    location = "East US"
    name     = "ntier-rg"
  }
}
variable "vnet_info" {
  type = object({
    name             = string
    address_space    = list(string)
    subnet_name      = string
    address_prefixes = list(string)
  })
  default = {
    address_space    = ["10.0.0.0/16"]
    name             = "ntier-vnet"
    subnet_name      = "web1"
    address_prefixes = ["10.0.0.0/24"]
  }
}

variable "vms_info" {
  type = map(object({
    nic_names       = string
    nic_ip_names    = string
    vm_names        = string
    vm_size         = string
    vm_username     = string
    image_publisher = string
    image_offer     = string
    image_sku       = string
    image_version   = string
    public_ip_names = string
    custom_data     = string
    zone            = number
  }))
  default = {
    "vm1" = {
      image_offer     = "0001-com-ubuntu-server-focal"
      image_publisher = "Canonical"
      image_sku       = "20_04-lts"
      image_version   = "latest"
      nic_ip_names    = "websrv1-ip"
      nic_names       = "websrv1-nic"
      vm_names        = "websrv1"
      vm_size         = "Standard_B1s"
      vm_username     = "srikanth"
      public_ip_names = "web1-ip"
      custom_data     = "D:/TRAINING/JIOP/Terraform/azure/multiple_vms/lampvm1.sh"
      zone            = 1
    }
    "vm2" = {

      image_offer     = "0001-com-ubuntu-server-focal"
      image_publisher = "Canonical"
      image_sku       = "20_04-lts"
      image_version   = "latest"
      nic_ip_names    = "websrv2-ip"
      nic_names       = "websrv2-nic"
      vm_names        = "websrv2"
      vm_size         = "Standard_B1s"
      vm_username     = "srikanth"
      public_ip_names = "web2-ip"
      custom_data     = "D:/TRAINING/JIOP/Terraform/azure/multiple_vms/lampvm2.sh"
      zone            = 2

    }

  }

}
variable "lb_info" {
  type = object({
    ip_name              = string
    ip_allocation_method = string
    lb_name              = string
    frontend_name        = string
    backend_name         = string
    probe_name           = string
    lb_rule_name         = string
  })
  default = {
    ip_allocation_method = "Static"
    backend_name         = "ntier-lb"
    frontend_name        = "ntier-frontend"
    ip_name              = "ntier-lb-ip"
    lb_name              = "ntier-lb"
    lb_rule_name         = "ntier-lb-rule1"
    probe_name           = "ntier-lb-probe"
  }
}