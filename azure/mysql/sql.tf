resource "random_password" "sqlpassword" {
  length  = 16
  special = true

}
resource "azurerm_resource_group" "sqlrg" {
  name     = "sqlrg"
  location = "East US"

}
resource "azurerm_mssql_server" "sqlsrv" {
  name                         = "srsqlsrv"
  resource_group_name          = azurerm_resource_group.sqlrg.name
  location                     = azurerm_resource_group.sqlrg.location
  version                      = "12.0"
  administrator_login          = "srikanthvelma"
  administrator_login_password = random_password.sqlpassword.result
  depends_on = [
    azurerm_resource_group.sqlrg,
    random_password.sqlpassword
  ]
}
resource "azurerm_mssql_database" "sqldb" {
  name      = "employessdb"
  server_id = azurerm_mssql_server.sqlsrv.id
  sku_name  = "Basic"

  depends_on = [
    azurerm_resource_group.sqlrg,
    azurerm_mssql_server.sqlsrv
  ]

}
output "sqlsrv_password" {
    value = random_password.sqlpassword
    sensitive = true
    description = "sqlserver password"
  
}