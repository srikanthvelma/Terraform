resource "azuread_user" "velma" {
  user_principal_name = "velma@velmasrikanth57outlook.onmicrosoft.com"
  display_name        = "velma"
  password            = "motherindia@123"

}

data "azurerm_subscription" "Azure1" {

}
data "azurerm_client_config" "rolefor_vms" {

}
resource "azurerm_role_definition" "rolefor_vms" {
  name  = "custom-role-vms"
  scope = data.azurerm_subscription.Azure1.id

  permissions {
    actions     = ["Microsoft.Compute/*", "Microsoft.Sql/*/read"]
    not_actions = []
  }
  assignable_scopes = [data.azurerm_subscription.Azure1.id]
}
resource "azurerm_role_assignment" "rolefor_vms" {
  scope = data.azurerm_subscription.Azure1.id
  principal_id = data.azurerm_client_config.rolesfor_vms.object_id

}