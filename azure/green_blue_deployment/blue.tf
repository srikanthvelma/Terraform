module "blue_vm" {
  source = "git::https://github.com/srikanthvelma/spc-terraform.git"

  subnet_info = {
    address_prefixes = ["192.168.0.0/24"]
    subnet_name      = "web1"
  }

  vm_nic_info = {
    nic_ip_allocation    = "Dynamic"
    nic_ip_name          = "bluesrvip"
    nic_name             = "bluesrvnic"
    public_ip_allocation = "Dynamic"
    public_ip_name       = "blueip"
  }

  vm_info = {
    vm_name     = "bluevm"
    vm_password = "Motherindia@123"
    vm_size     = "Standard_B1s"
    vm_username = "srikanthvelma"
  }

}
resource "null_resource" "blue_executor" {
  triggers = {
    "blue_rollout_version" = var.blue_rollout_version

  }
  connection {
    type     = "ssh"
    user     = "srikanth"
    password = "Motherindia@123"
    host     = "module.blue_vm.azurerm_linux_virtual_machine.azvm.public_ip_address"
  }
  provisioner "remote-exec" {
    script = "./java.sh"
  }
  depends_on = [
    module.blue_vm

  ]
}







