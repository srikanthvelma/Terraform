module "green_vm" {
  source = "./az_multi_vms"
  subnet_info = {
    address_prefixes = ["10.0.1.0/24"]
    nsg_name         = "greennsg"
    subnet_name      = "web2"
  }
  vms_info = {
    "green" = {
      custom_data     = "empty.sh"
      image_offer     = "0001-com-ubuntu-server-focal"
      image_publisher = "Canonical"
      image_sku       = "20_04-lts"
      image_version   = "latest"
      nic_ip_names    = "greensrv-ip"
      nic_names       = "greensrv-nic"
      public_ip_names = "green-ip"
      vm_names        = "green-vm"
      vm_size         = "Standard_B1s"
      vm_username     = "srikanth"
      zone            = 2
    }
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
    host     = "module.green_vm.azurerm_linux_virtual_machine.ntiervms[green].public_ip_address"
  }
  provisioner "remote-exec" {
    script = "./java.sh"
  }
  depends_on = [
    module.green_vm

  ]
}
