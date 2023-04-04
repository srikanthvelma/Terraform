resource "azurerm_public_ip" "lb_publicip" {
    name = "lb_publicip"
    resource_group_name = azurerm_resource_group.ntierrg.name
    location = azurerm_resource_group.ntierrg.location
    allocation_method = "static"
}

resource "azurerm_lb" "ntierlb" {
    name = "ntierlb"
    location = azurerm_resource_group.ntierrg.location
    resource_group_name = azurerm_resource_group.ntierrg.name
    frontend_ip_configuration {
      name = "lbfrontend"
      subnet_id = azurerm_subnet.ntiersubnets.id
      public_ip_address_id = azurerm_public_ip.lb_publicip.id
    }
}
resource "azurerm_lb_backend_address_pool" "lb_backend" {
    loadbalancer_id = azurerm_lb.ntierlb.id
    name = "lb_backend"
    virtual_network_id = azurerm_virtual_network.ntiervnet.id
  
}