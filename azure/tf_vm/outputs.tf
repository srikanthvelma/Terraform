output "print" {
  value = azurerm_linux_virtual_machine.tfvm[0].source_image_reference[0].sku

}