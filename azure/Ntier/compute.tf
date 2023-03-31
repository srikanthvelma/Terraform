resource "azurerm_public_ip" "ntier_public_ip" {
  name                = "ntier_public_ip"
  resource_group_name = azurerm_resource_group.ntierrg.name
  location            = azurerm_resource_group.ntierrg.location
  allocation_method   = "Dynamic"
}
resource "azurerm_network_interface" "ntiernic" {
  name                = var.vm_nic_info.nic_name
  resource_group_name = azurerm_resource_group.ntierrg.name
  location            = azurerm_resource_group.ntierrg.location
  ip_configuration {
    name                          = var.vm_nic_info.nic_ip_name
    subnet_id                     = azurerm_subnet.ntiersubnets[var.vm_nic_info.subnet_index].id
    private_ip_address_allocation = var.vm_nic_info.nic_ip_allocation
    public_ip_address_id          = azurerm_public_ip.ntier_public_ip.id
  }
  depends_on = [
    azurerm_resource_group.ntierrg,
    azurerm_virtual_network.ntiervnet,
    azurerm_subnet.ntiersubnets
  ]

}

resource "azurerm_linux_virtual_machine" "ntiervms" {
  count               = length(var.vm_info.vm_names)
  name                = var.vm_info.vm_names[count.index]
  resource_group_name = azurerm_resource_group.ntierrg.name
  location            = azurerm_resource_group.ntierrg.location
  size                = var.vm_info.vm_size
  admin_username      = var.vm_info.vm_username
  network_interface_ids = [
    azurerm_network_interface.ntiernic.id
  ]
  admin_ssh_key {
    username   = var.vm_info.vm_username
    public_key = file("~/.ssh/id_rsa.pub")
  }
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
    azurerm_network_interface.ntiernic
  ]
}