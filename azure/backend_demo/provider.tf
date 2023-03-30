terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.48.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraformbackend"
    storage_account_name = "srterraformbackend"
    container_name       = "terraformstate"
    key                  = "test.terraform.tfstate"

  }
}
provider "azurerm" {
  features {}

}