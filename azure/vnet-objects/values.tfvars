resource_group_info = {
  location = "Central India"
  rg_name  = "vnetgroup"
}
virtual_network_info = {
  address_space = ["10.0.0.0/16"]
  subnet_names  = ["app1", "app2", "app3", "db1", "db2", "db3"]
  vnet_name     = "vnet2"
}
