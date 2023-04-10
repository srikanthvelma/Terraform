output "vm1_public_ip" {
  value = "module.azure_vm1.azurerm_linux_virtual_machine.azvm.public_ip_address"
}
output "vm1_private_ip" {
  value = "module.azure_vm1.azurerm_linux_virtual_machine.azvm.private_ip_address"
}
output "vm2_public_ip" {
  value = "module.azure_vm2.azurerm_linux_virtual_machine.azvm.public_ip_address"
}
output "vm2_private_ip" {
  value = "module.azure_vm2.azurerm_linux_virtual_machine.azvm.private_ip_address"
}