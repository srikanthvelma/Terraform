resource "azurerm_resource_group" "azgroup" {
  name     = "azgroup"
  location = "east us"

}
# resource "azurerm_network_interface" "azvm-nic" {
#   name                = "azvm-nic"
#   location            = azurerm_resource_group.azgroup.location
#   resource_group_name = azurerm_resource_group.azgroup.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.example.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }
resource "azurerm_linux_virtual_machine" "azvm" {
  name                            = "azvm"
  resource_group_name             = azurerm_resource_group.azgroup.name
  location                        = azurerm_resource_group.azgroup.location
  size                            = "Standard_B1s"
  admin_username                  = "velma"
  admin_password                  = "Motherindia@123"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}