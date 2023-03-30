terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.48.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "terraformbackend"
    storage_account_name = "srterraformbackend"
    container_name = "terraformstate"
    key = "j2f8LyRqxeZHOtDu5bItWG+1yYcl1y8uQAUhXZ0w9Nlvuu6ZrtNqTQyW5KbdTOKcGGtK+s4zfjXG+AStorv17w=="
    
  }
}
provider "azurerm" {
  features {}

}