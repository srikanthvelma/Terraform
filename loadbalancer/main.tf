resource "azurerm_resource_group" "abresource" {
  name     = var.narmada.name
  location = var.narmada.location
  tags = {
    env = var.narmada.tags
  }
}
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet.name
  resource_group_name = var.narmada.name
  location            = var.narmada.location
  address_space       = var.vnet.address_space
  tags = {
    env = var.vnet.tags
  }
  depends_on = [azurerm_resource_group.abresource]
}
resource "azurerm_subnet" "subnets" {
  count                = var.vms
  name                 = "web-${count.index}"
  resource_group_name  = var.narmada.name
  virtual_network_name = var.vnet.name
  address_prefixes     = [cidrsubnet("10.0.0.0/16", 8, count.index)]

  depends_on = [azurerm_resource_group.abresource,
  azurerm_virtual_network.vnet]
}
resource "azurerm_public_ip" "pubip" {
  count               = var.vms
  name                = "pubip-${count.index}"
  resource_group_name = var.narmada.name
  location            = var.narmada.location
  allocation_method   = var.pubip.allocation_method
  tags = {
    env = var.pubip.tags
  }
  depends_on = [azurerm_resource_group.abresource]
}
resource "azurerm_network_interface" "nic" {
  count               = var.vms
  name                = "nic-${count.index}"
  resource_group_name = var.narmada.name
  location            = var.narmada.location
  ip_configuration {
    name                          = "nic-${count.index}"
    subnet_id                     = azurerm_subnet.subnets[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pubip[count.index].id
  }
  depends_on = [azurerm_resource_group.abresource,
    azurerm_virtual_network.vnet,
    azurerm_subnet.subnets
  ]

}
resource "azurerm_linux_virtual_machine" "vms" {
  count               = var.vms
  name                = "vm-${count.index}"
  resource_group_name = var.narmada.name
  location            = var.narmada.location
  # availability_set_id = azurerm_availability_set.vmset[0].id
  size                  = var.vm_info.size
  admin_username        = var.vm_info.admin_username
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]

  admin_ssh_key {
    username   = var.vm_info.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = var.source_image.publisher
    offer     = var.source_image.offer
    sku       = var.source_image.sku
    version   = var.source_image.version
  }
  depends_on = [azurerm_resource_group.abresource]

}
resource "null_resource" "executor" {
  count = var.vms
  triggers = {
    rollout_version = "0.0.1.0"
  }
  connection {
    type        = "ssh"
    user        = azurerm_linux_virtual_machine.vms[0].admin_username
    private_key = file("~/.ssh/id_rsa")
    host        = azurerm_linux_virtual_machine.vms[0].public_ip_address
  }
  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install apache2 -y"]

  }
  depends_on = [azurerm_linux_virtual_machine.vms]
}
resource "null_resource" "executou1" {
  count = var.vms
  triggers = {
    rollout_version = "0.0.2.0"
  }
  connection {
    type        = "ssh"
    user        = azurerm_linux_virtual_machine.vms[1].admin_username
    private_key = file("~/.ssh/id_rsa")
    host        = azurerm_linux_virtual_machine.vms[1].public_ip_address
  }
  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install nginx -y"]

  }
  depends_on = [azurerm_linux_virtual_machine.vms]
}