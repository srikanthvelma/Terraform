resource "azurerm_resource_group" "ntierrg" {
  name     = var.rg_info.name
  location = var.rg_info.location
}
resource "azurerm_public_ip" "ntier_public_ips" {
  for_each            = var.vms_info
  name                = each.value.public_ip_names
  resource_group_name = azurerm_resource_group.ntierrg.name
  location            = azurerm_resource_group.ntierrg.location
  allocation_method   = "Static"
  zones = [each.value.zone]
  sku = "Standard"
}
resource "azurerm_network_interface" "ntiernic" {
  for_each            = var.vms_info
  name                = each.value.nic_names
  resource_group_name = azurerm_resource_group.ntierrg.name
  location            = azurerm_resource_group.ntierrg.location
  ip_configuration {
    name                          = each.value.nic_ip_names
    subnet_id                     = azurerm_subnet.ntiersubnets.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ntier_public_ips[each.key].id
  }
  depends_on = [
    azurerm_resource_group.ntierrg,
    azurerm_virtual_network.ntiervnet,
    azurerm_subnet.ntiersubnets
  ]
}
resource "azurerm_linux_virtual_machine" "ntiervms" {
  for_each            = var.vms_info
  name                = each.value.vm_names
  resource_group_name = azurerm_resource_group.ntierrg.name
  location            = azurerm_resource_group.ntierrg.location
  size                = each.value.vm_size
  admin_username      = each.value.vm_username
  custom_data         = filebase64(each.value.custom_data)
  zone                = each.value.zone
  network_interface_ids = [
    azurerm_network_interface.ntiernic[each.key].id
  ]
  admin_ssh_key {
    username   = each.value.vm_username
    public_key = file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = each.value.image_publisher
    offer     = each.value.image_offer
    sku       = each.value.image_sku
    version   = each.value.image_version
  }
  depends_on = [
    azurerm_network_interface.ntiernic,
    azurerm_public_ip.ntier_public_ips
  ]
}