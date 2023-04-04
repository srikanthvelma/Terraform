resource "azurerm_public_ip" "ntier_public_ip" {
  name                = "ntier_public_ip"
  resource_group_name = azurerm_resource_group.ntierrg.name
  location            = azurerm_resource_group.ntierrg.location
  allocation_method   = "Dynamic"
}
resource "azurerm_network_interface" "ntiernic" {
  name                = var.vm_nic_info.nic_name
  resource_group_name = azurerm_resource_group.ntierrg.name
  location            = azurerm_resource_group.ntierrg.location
  ip_configuration {
    name                          = var.vm_nic_info.nic_ip_name
    subnet_id                     = azurerm_subnet.ntiersubnets[var.vm_nic_info.subnet_index].id
    private_ip_address_allocation = var.vm_nic_info.nic_ip_allocation
    public_ip_address_id          = azurerm_public_ip.ntier_public_ip.id
  }
  depends_on = [
    azurerm_resource_group.ntierrg,
    azurerm_virtual_network.ntiervnet,
    azurerm_subnet.ntiersubnets
  ]

}

resource "azurerm_linux_virtual_machine" "ntiervms" {
  count               = length(var.vm_info.vm_names)
  name                = var.vm_info.vm_names[count.index]
  resource_group_name = azurerm_resource_group.ntierrg.name
  location            = azurerm_resource_group.ntierrg.location
  size                = var.vm_info.vm_size
  admin_username      = var.vm_info.vm_username
  custom_data         = filebase64("apache.sh")
  network_interface_ids = [
    azurerm_network_interface.ntiernic.id
  ]
  admin_ssh_key {
    username   = var.vm_info.vm_username
    public_key = file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = var.image_info.publisher
    offer     = var.image_info.offer
    sku       = var.image_info.sku
    version   = var.image_info.version
  }

  depends_on = [
    azurerm_network_interface.ntiernic
  ]
}
resource "azurerm_public_ip" "lb_publicip" {
  name                = "lb_publicip"
  resource_group_name = azurerm_resource_group.ntierrg.name
  location            = azurerm_resource_group.ntierrg.location
  allocation_method   = "Static"

}

resource "azurerm_lb" "ntierlb" {
  name                = "ntierlb"
  location            = azurerm_resource_group.ntierrg.location
  resource_group_name = azurerm_resource_group.ntierrg.name
  frontend_ip_configuration {
    name                 = "lbfrontend"
    public_ip_address_id = azurerm_public_ip.lb_publicip.id
  }
}
resource "azurerm_lb_backend_address_pool" "lb_backend" {
  loadbalancer_id = azurerm_lb.ntierlb.id
  name            = "lb_backend"
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_backend_assc" {
  network_interface_id    = azurerm_network_interface.ntiernic.id
  ip_configuration_name   = azurerm_network_interface.ntiernic.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend.id
}
resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id     = azurerm_lb.ntierlb.id
  name                = "ntierlbprobe"
  port                = 80
  interval_in_seconds = 10
  number_of_probes    = 3
  protocol            = "Http"
  request_path        = "/"
}

resource "azurerm_lb_rule" "lb_rule1" {
  loadbalancer_id                = azurerm_lb.ntierlb.id
  name                           = "ntierlb_rule1"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "lbfrontend"
  probe_id                       = azurerm_lb_probe.lb_probe.id
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.lb_backend.id]
}

