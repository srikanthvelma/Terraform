resource "azurerm_resource_group" "azresource" {
    name = var.resource.name
    location = var.resource.location
    tags = {
        "env" = "dev"
    }

  
}