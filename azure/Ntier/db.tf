resource "azurerm_mssql_server" "ntier_sqlserver" {
  name                         = var.sqlsrv_info.sqlsrv_name
  resource_group_name          = local.rg_name
  location                     = local.location
  version                      = "12.0"
  administrator_login          = var.sqlsrv_info.administrator_login
  administrator_login_password = var.sqlsrv_info.administrator_login_password
  depends_on = [
    azurerm_resource_group.ntierrg,
    azurerm_virtual_network.ntiervnet,
    azurerm_subnet.ntiersubnets
  ]
}
resource "azurerm_mssql_database" "sqldb" {
  name        = var.sqlsrv_info.sqldb_name
  server_id   = azurerm_mssql_server.ntier_sqlserver.id
  sample_name = "AdventureWorksLT"
  sku_name    = var.sqlsrv_info.sku_name
  depends_on = [
    azurerm_mssql_server.ntier_sqlserver
  ]
}