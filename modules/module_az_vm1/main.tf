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
  source = "./azure_vm1"
  
  resource "null_resource" "spc" {

    connection {
      type = "ssh"
      user = srikanthvelma
      password = var.vm_info.vm_password
      host = azurerm_public_ip.az_public_ip.ip_address
    }

    provisioner "file" {
      source = "./modules/module_az_vm1/spc.service"
      destination = "/etc/systemd/system/spc.service"
    }
    provisioner "remote-exec" {
      script = filebase64("spc.sh")
    }
  }
}





