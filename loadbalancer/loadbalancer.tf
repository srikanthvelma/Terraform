resource "azurerm_public_ip" "lbpub" {
  name                = var.lbpub.name
  resource_group_name = var.narmada.name
  location            = var.narmada.location
  allocation_method   = var.lbpub.allocation_method
  depends_on          = [azurerm_resource_group.abresource]
}
resource "azurerm_lb" "loadbalancer" {
  name                = "load-balancer"
  resource_group_name = var.narmada.name
  location            = var.narmada.location
  frontend_ip_configuration {
    name                 = "loadbalancerip"
    public_ip_address_id = azurerm_public_ip.lbpub.id
  }
}
resource "azurerm_lb_backend_address_pool" "backendlb" {
  # count = var.vms
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "backendpool"
}
resource "azurerm_lb_probe" "probe" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "lbprobe"
  port            = "80"
  protocol        = "Http"
  request_path    = "/"
}
resource "azurerm_lb_rule" "lbrule" {
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "lbpool"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "azurerm_lb.loadbalancer.frontend_ip_configuration.name"
  probe_id                       = azurerm_lb_probe.probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backendlb.id]
}
resource "azurerm_network_interface_backend_address_pool_association" "nsgpool" {
  count                   = var.vms
  network_interface_id    = azurerm_network_interface.nic[count.index].id
  ip_configuration_name   = "nic-${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backendlb.id

  depends_on = [azurerm_network_interface.nic]
}