terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.48.0"
    }
  }
}
provider "azurerm" {
  features {}
}

module "vms" {
  source = "./az_multi_vms"

  rg_info = {
    location = "East US"
    name     = "nop-rg"
  }
  vnet_info = {
    address_space = ["10.0.0.0/16"]
    name          = "nop-vnet"
  }
  subnet_info = {
    address_prefixes = ["10.0.0.0/24"]
    nsg_name         = "nopnsg"
    subnet_name      = "app1"
  }
  vms_info = {
    "vm1" = {
      custom_data     = "empty.sh"
      image_offer     = "0001-com-ubuntu-server-focal"
      image_publisher = "Canonical"
      image_sku       = "20_04-lts"
      image_version   = "latest"
      nic_ip_names    = "appsrv1-nicip"
      nic_names       = "appsrv1-nic"
      public_ip_names = "appsrv1-ip"
      vm_names        = "appsrv1"
      vm_size         = "Standard_B1s"
      vm_username     = "srikanth"
      vm_password     = "Motherindia@123"
      zone            = 1
    }
    "vm2" = {
      custom_data     = "mysql.sh"
      image_offer     = "0001-com-ubuntu-server-focal"
      image_publisher = "Canonical"
      image_sku       = "20_04-lts"
      image_version   = "latest"
      nic_ip_names    = "mysql-nicip"
      nic_names       = "mysql-nic"
      public_ip_names = "mysql-ip"
      vm_names        = "mysql"
      vm_size         = "Standard_B1s"
      vm_username     = "srikanth"
      vm_password     = "Motherindia@123"
      zone            = 1
    }
  }
}
resource "null_resource" "executor" {
  triggers = {
    "rollout_version" = "0.0.0.2"
  }
  connection {
    type     = "ssh"
    user     = "srikanth"
    password = "Motherindia@123"
    host     = module.vms.publicip
  }
  provisioner "file" {
    source      = "./nop.service"
    destination = "/home/srikanth/nop.service"
  }
  provisioner "file" {
    source      = "./nop.sh"
    destination = "/home/srikanth/nop.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x nop.sh",
      "./nop.sh"
    ]
  }
}

