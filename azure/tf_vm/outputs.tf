output "print" {
    value = azurerm_linux_virtual_machine.tfvm[0].user_data
}