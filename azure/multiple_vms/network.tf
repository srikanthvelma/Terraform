resource "azurerm_virtual_network" "ntiervnet" {
  name                = var.vnet_info.name
  resource_group_name = azurerm_resource_group.ntierrg.name
  location            = azurerm_resource_group.ntierrg.location
  address_space       = var.vnet_info.address_space
  depends_on = [
    azurerm_resource_group.ntierrg
  ]
}
resource "azurerm_subnet" "ntiersubnets" {
  name                 = var.vnet_info.subnet_name
  address_prefixes     = var.vnet_info.address_prefixes
  virtual_network_name = azurerm_virtual_network.ntiervnet.name
  resource_group_name  = azurerm_resource_group.ntierrg.name

  depends_on = [
    azurerm_virtual_network.ntiervnet
  ]
}
resource "azurerm_network_security_group" "ntiernsg" {
  name                = "ntiernsg"
  resource_group_name = azurerm_resource_group.ntierrg.name
  location            = azurerm_resource_group.ntierrg.location
  depends_on = [
    azurerm_subnet.ntiersubnets
  ]
}
resource "azurerm_network_security_rule" "ntiernsg_rule" {
  name                        = "HTTP"
  resource_group_name         = azurerm_resource_group.ntierrg.name
  network_security_group_name = azurerm_network_security_group.ntiernsg.name
  priority                    = 320
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  depends_on = [
    azurerm_network_security_group.ntiernsg
  ]

}
resource "azurerm_network_security_rule" "ntiernsg_rule2" {
  name                        = "SSH"
  resource_group_name         = azurerm_resource_group.ntierrg.name
  network_security_group_name = azurerm_network_security_group.ntiernsg.name
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  depends_on = [
    azurerm_network_security_group.ntiernsg
  ]
}
resource "azurerm_network_security_rule" "ntiernsg_rule3" {
  name                        = "all"
  resource_group_name         = azurerm_resource_group.ntierrg.name
  network_security_group_name = azurerm_network_security_group.ntiernsg.name
  priority                    = 400
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  depends_on = [
    azurerm_network_security_group.ntiernsg
  ]
}
resource "azurerm_subnet_network_security_group_association" "ntiernsg_assc" {
  subnet_id                 = azurerm_subnet.ntiersubnets.id
  network_security_group_id = azurerm_network_security_group.ntiernsg.id
}