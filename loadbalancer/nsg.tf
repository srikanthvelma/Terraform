resource "azurerm_network_security_group" "nsg-group" {
  name                = "nsg_group"
  resource_group_name = "ab-resource"
  location            = "East Us"
  depends_on          = [azurerm_resource_group.abresource]
}
resource "azurerm_network_security_rule" "nsg-rule1" {
  name                        = "nsg1"
  resource_group_name         = var.narmada.name
  network_security_group_name = azurerm_network_security_group.nsg-group.name
  priority                    = "300"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}
resource "azurerm_network_security_rule" "nsg-rule2" {
  name                        = "nsg2"
  resource_group_name         = var.narmada.name
  network_security_group_name = azurerm_network_security_group.nsg-group.name
  priority                    = "320"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}
# resource "azurerm_network_security_rule" "nsg-rule3" {
#     name = "nsg3"
#     resource_group_name = var.narmada.name
#     network_security_group_name = azurerm_network_security_group.nsg-group.name
#     priority = "400"
#     direction = "Outbound"
#     access = "Allow"
#     protocol = "Tcp"
#     source_port_range = "*"
#     destination_port_range = "*"
#     source_address_prefix = "*"
#     destination_address_prefix = "*"
# }
resource "azurerm_subnet_network_security_group_association" "nsg-ssc" {
  count                     = var.vms
  subnet_id                 = azurerm_subnet.subnets[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg-group.id
}
 