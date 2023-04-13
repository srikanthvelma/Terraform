module "blue_vm" {
  source = "./az_multi_vms"
  subnet_info = {
    address_prefixes = ["10.0.0.0/24"]
    nsg_name         = "bluensg"
    subnet_name      = "web1"
  }
  vms_info = {
    "blue" = {
      custom_data     = "empty.sh"
      image_offer     = "0001-com-ubuntu-server-focal"
      image_publisher = "Canonical"
      image_sku       = "20_04-lts"
      image_version   = "latest"
      nic_ip_names    = "bluesrv-ip"
      nic_names       = "bluesrv-nic"
      public_ip_names = "blue-ip"
      vm_names        = "blue-vm"
      vm_size         = "Standard_B1s"
      vm_username     = "srikanth"
      zone            = 1
    }
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
    host     = "module.blue_vm[blue].azurerm_linux_virtual_machine.ntiervms[blue].public_ip_address"
  }
  provisioner "remote-exec" {
    script = "./java.sh"
  }
  depends_on = [
    module.blue_vm

  ]
}
