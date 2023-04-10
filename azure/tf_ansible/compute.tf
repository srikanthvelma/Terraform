resource "azurerm_public_ip" "tf_public_ip" {
  name                = "tf_public_ip"
  resource_group_name = azurerm_resource_group.tfrg.name
  location            = azurerm_resource_group.tfrg.location
  allocation_method   = "Dynamic"
}
resource "azurerm_network_interface" "tfnic" {
  name                = var.vm_nic_info.nic_name
  resource_group_name = azurerm_resource_group.tfrg.name
  location            = azurerm_resource_group.tfrg.location
  ip_configuration {
    name                          = var.vm_nic_info.nic_ip_name
    subnet_id                     = azurerm_subnet.tfsubnets[var.vm_nic_info.subnet_index].id
    private_ip_address_allocation = var.vm_nic_info.nic_ip_allocation
    public_ip_address_id          = azurerm_public_ip.tf_public_ip.id
  }
  depends_on = [
    azurerm_resource_group.tfrg,
    azurerm_virtual_network.tfvnet,
    azurerm_subnet.tfsubnets
  ]

}

resource "azurerm_linux_virtual_machine" "tfvm" {
  name                            = var.vm_info.vm_names
  resource_group_name             = azurerm_resource_group.tfrg.name
  location                        = azurerm_resource_group.tfrg.location
  size                            = var.vm_info.vm_size
  user_data                       = filebase64("ansible.sh")
  admin_username                  = var.vm_info.vm_username
  admin_password                  = var.vm_info.vm_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.tfnic.id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = var.image_info.publisher
    offer     = var.image_info.offer
    sku       = var.image_info.sku
    version   = var.image_info.version
  }
  depends_on = [
    azurerm_network_interface.tfnic
  ]
}

data "template_file" "inventory" {
  template =<<EOF
  ${azurerm_linux_virtual_machine.tfvm.private_ip_address} ansible_user=srikanthvelma
  EOF
}
output "inventory" {
  value = data.template_file.inventory.rendered
}

resource "null_resource" "executor" {
  triggers = {
    "rollout_version" = "0.0.0.1"
  }
  connection {
    type     = "ssh"
    user     = "srikanthvelma"
    password = "Motherindia@123"
    host     = azurerm_linux_virtual_machine.tfvm.public_ip_address
  }
  provisioner "file" {
    source      = "./spc.service"
    destination = "/home/srikanthvelma/spc.service"
  }
  provisioner "file" {
    source      = "./spc.yaml"
    destination = "/home/srikanthvelma/spc.yaml"

  }
  provisioner "file" {
    source      = "./password"
    destination = "/home/srikanthvelma/password"  # we can pass privatekey also

  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install openjdk-17-jdk -y",
      "echo ${azurerm_linux_virtual_machine.tfvm.private_ip_address} >> /home/srikanthvelma/hosts",
      "ansible-playbook --connection-password-file password -i hosts spc.yaml" # we can pass privatekey also
    ]
  }
}


