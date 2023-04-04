output "vnet" {
  value = azurerm_virtual_network.ntiervnet.id
}
output "loadbalancer" {
  value = azurerm_lb.ntierlb.id
}
output "lb_backend" {
  value = azurerm_lb_backend_address_pool.lb_backend.id
}