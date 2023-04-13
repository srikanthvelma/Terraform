output "green_pub_ip" {
    value = "module.blue_vm.azurerm_virtual_machine.ntiervms[blue].public_ip_address"
}