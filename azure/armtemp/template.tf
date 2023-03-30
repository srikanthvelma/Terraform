resource "azurerm_resource_group" "armvnet" {
  name     = "armvnet"
  location = "East US"
}
resource "azurerm_resource_group_template_deployment" "vnettemplate" {
  name                = "vnet_armtemplate"
  resource_group_name = azurerm_resource_group.armvnet.name
  deployment_mode     = "Incremental"
  template_content    = file("D:/TRAINING/JIOP/ARMTemplates/task.json")
}