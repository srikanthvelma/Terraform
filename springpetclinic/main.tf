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
module "azure_vm1" {
  source = "git::https://github.com/srikanthvelma/spc-terraform.git"

}
module "azure_vm2" {
  source = "git::https://github.com/srikanthvelma/spc-terraform.git"

  vm_nic_info = {
    nic_ip_allocation    = "Dynamic"
    nic_ip_name          = "greensrvip"
    nic_name             = "greensrvnic"
    public_ip_allocation = "Dynamic"
    public_ip_name       = "greenip"
  }

  vm_info = {
    vm_name     = "greenvm"
    vm_password = "Motherindia@123"
    vm_size     = "Standard_B1s"
    vm_username = "srikanthvelma"
  }

}
resource "null_resource" "executor" {
  triggers = {
    "rollout_version" = "0.0.0.1"
  }
  connection {
    type     = "ssh"
    user     = "srikanthvelma"
    password = "Motherindia@123"
    host     = "module.azure_vm1.azurerm_linux_virtual_machine.azvm.public_ip_address"
                
  }
  provisioner "file" {
    source      = "./spc.service"
    destination = "/tmp/spc.service"

  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install openjdk-17-jdk -y",
      "sudo apt install maven -y",
      "sudo cp /tmp/spc.service /etc/systemd/system/spc.service",
      "git clone https://github.com/spring-projects/spring-petclinic.git",
      "cd spring-petclinic",
      "./mvnw package",
      "sudo systemctl daemon-reload",
      "sudo systemctl start spc.service"
    ]
  }
}







