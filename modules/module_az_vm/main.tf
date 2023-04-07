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

module "azure_vm" {
  source = "./azure_vm"

  count = length(var.vm_info.vm_name)
  subnet_info = {
    subnet_name      = var.subnet_info.subnet_name[count.index]
    address_prefixes = [var.subnet_info.address_prefixes[count.index]]
  }
  vm_nic_info = {
    nic_name       = var.vm_nic_info.nic_name[count.index]
    nic_ip_name    = var.vm_nic_info.nic_ip_name[count.index]
    public_ip_name = var.vm_nic_info.public_ip_name[count.index]
    public_ip_allocation = var.vm_nic_info.public_ip_allocation
    nic_ip_allocation = var.vm_nic_info.nic_ip_allocation
  }
  vm_info = {
    vm_name     = var.vm_info.vm_name[count.index]
    vm_size     = "Standard_B1s"
    vm_username = "srikanthvelma"
    vm_password = "Motherindia@123"
  }
}




