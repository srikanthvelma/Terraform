module "green_vm" {
  source = "git::https://github.com/srikanthvelma/spc-terraform.git"

  subnet_info = {
    address_prefixes = ["192.168.1.0/24"]
    subnet_name      = "web2"
  }

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
    vm_username = "srikanth"
  }
}
resource "null_resource" "green_executor" {
  triggers = {
    "green_rollout_version" = var.green_rollout_version
  }
  connection {
    type     = "ssh"
    user     = "srikanth"
    password = "Motherindia@123"
    host     = "module.green_vm.azurerm_linux_virtual_machine.azvm.public_ip_address"
  }
  provisioner "file" {
    source      = "./java.sh"
    destination = "/home/srikanth/java.sh"

  }
  provisioner "remote-exec" {
    script = "./java.sh"
  }
  depends_on = [
    module.green_vm
  ]
}