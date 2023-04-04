resource_group_info = {
  location = "East US"
  rg_name  = "ntier-rg"
}
virtual_network_info = {
  address_space = ["10.0.0.0/16"]
  subnet_names  = ["web2", "app2", "db2"]
  vnet_name     = "ntier-vnet"
}
vm_info = {
  vm_names    = ["websrv2"]
  vm_size     = "Standard_B1s"
  vm_username = "srikanth"
}
image_info = {
  offer     = "0001-com-ubuntu-server-focal"
  publisher = "Canonical"
  sku       = "20_04-lts"
  version   = "latest"
}