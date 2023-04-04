resource "azurerm_public_ip" "lb_publicip" {
  name                = var.lb_info.ip_name
  resource_group_name = azurerm_resource_group.ntierrg.name
  location            = azurerm_resource_group.ntierrg.location
  allocation_method   = var.lb_info.ip_allocation_method
  sku = "Standard"
}

resource "azurerm_lb" "ntierlb" {
  name                = var.lb_info.lb_name
  location            = azurerm_resource_group.ntierrg.location
  resource_group_name = azurerm_resource_group.ntierrg.name
  sku = "Standard"
  frontend_ip_configuration {
    name                 = var.lb_info.frontend_name
    public_ip_address_id = azurerm_public_ip.lb_publicip.id
  }
  depends_on = [
    azurerm_linux_virtual_machine.ntiervms,
    azurerm_public_ip.lb_publicip
  ]
}
resource "azurerm_lb_backend_address_pool" "lb_backend" {
  loadbalancer_id = azurerm_lb.ntierlb.id
  name            = var.lb_info.backend_name
  depends_on = [
    azurerm_lb.ntierlb,
    azurerm_linux_virtual_machine.ntiervms
  ]
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_backend_assc" {
  for_each                = var.vms_info
  network_interface_id    = azurerm_network_interface.ntiernic[each.key].id
  ip_configuration_name   = each.value.nic_ip_names
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend.id
  depends_on = [
    azurerm_network_interface.ntiernic,
    azurerm_lb_backend_address_pool.lb_backend
  ]
}
resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id     = azurerm_lb.ntierlb.id
  name                = var.lb_info.probe_name
  port                = 80
  interval_in_seconds = 10
  number_of_probes    = 3
  protocol            = "Http"
  request_path        = "/"
}

resource "azurerm_lb_rule" "lb_rule1" {
  loadbalancer_id                = azurerm_lb.ntierlb.id
  name                           = var.lb_info.lb_rule_name
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.ntierlb.frontend_ip_configuration[0].name
  probe_id                       = azurerm_lb_probe.lb_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backend.id]
}
