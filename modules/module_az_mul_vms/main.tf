terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.48.0"
    }
  }
}
provider "azurerm" {
  features {

  }
}

module "vm1" {
  source = "./az_multi_vms"

  rg_info = {
    location = "East US"
    name     = "ntier-rg"
  }
  vnet_info = {
    address_space = ["10.0.0.0/16"]
    name          = "ntier-vnet"
  }
  subnet_info = {
      address_prefixes = ["10.0.0.0/24"]
      nsg_name         = "ntiernsg"
      subnet_name      = "web1"
    }
  vms_info = {
    "vm1" = {
      custom_data     = "empty.sh"
      image_offer     = "0001-com-ubuntu-server-focal"
      image_publisher = "Canonical"
      image_sku       = "20_04-lts"
      image_version   = "latest"
      nic_ip_names    = "websrv1-nicip"
      nic_names       = "websrv1-nic"
      public_ip_names = "websrv1-ip"
      vm_names        = "websrv1"
      vm_size         = "Standard_B1s"
      vm_username     = "srikanth"
      zone            = 1
    }
    "vm2" = {
      custom_data     = "empty.sh"
      image_offer     = "0001-com-ubuntu-server-focal"
      image_publisher = "Canonical"
      image_sku       = "20_04-lts"
      image_version   = "latest"
      nic_ip_names    = "websrv2-nicip"
      nic_names       = "websrv2-nic"
      public_ip_names = "websrv2-ip"
      vm_names        = "websrv2"
      vm_size         = "Standard_B1s"
      vm_username     = "srikanth"
      zone            = 1
    }
  }
}