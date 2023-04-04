resource "azurerm_resource_group" "ntierrg" {
  name     = var.resource_group_info.rg_name
  location = var.resource_group_info.location
}

resource "azurerm_network_security_group" "ntiernsg" {
  name                = "ntiernsg"
  resource_group_name = local.rg_name
  location            = local.location
}
resource "azurerm_network_security_rule" "ntiernsg_rule" {
  name                        = "HTTP"
  resource_group_name         = local.rg_name
  network_security_group_name = local.nsg_name
  priority                    = 320
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"

}
resource "azurerm_network_security_rule" "ntiernsg_rule2" {
  name                        = "SSH"
  resource_group_name         = local.rg_name
  network_security_group_name = local.nsg_name
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}
resource "azurerm_network_security_rule" "ntiernsg_rule3" {
  name                        = "all"
  resource_group_name         = local.rg_name
  network_security_group_name = local.nsg_name
  priority                    = 400
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}
resource "azurerm_subnet_network_security_group_association" "ntiernsg_assc" {
  subnet_id                 = azurerm_subnet.ntiersubnets[var.vm_nic_info.subnet_index].id
  network_security_group_id = azurerm_network_security_group.ntiernsg.id
}
resource "azurerm_virtual_network" "ntiervnet" {
  name                = var.virtual_network_info.vnet_name
  resource_group_name = azurerm_resource_group.ntierrg.name
  location            = azurerm_resource_group.ntierrg.location
  address_space       = var.virtual_network_info.address_space
  depends_on = [
    azurerm_resource_group.ntierrg
  ]
}
resource "azurerm_subnet" "ntiersubnets" {
  count                = length(var.virtual_network_info.subnet_names)
  name                 = var.virtual_network_info.subnet_names[count.index]
  virtual_network_name = azurerm_virtual_network.ntiervnet.name
  resource_group_name  = azurerm_resource_group.ntierrg.name
  address_prefixes     = [cidrsubnet(var.virtual_network_info.address_space[0], 8, count.index)]
  depends_on = [
    azurerm_virtual_network.ntiervnet
  ]
}