output "publicip" {
    value = azurerm_linux_virtual_machine.ntiervms["vm1"].public_ip_address     
}