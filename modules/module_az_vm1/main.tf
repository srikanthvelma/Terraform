terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.48.0"
    }
  }
}
provider "azurerm" {
  features {

  }
}
module "azure_vm" {
  source = "git::https://github.com/srikanthvelma/spc-terraform.git"

  rollout_version = "0.0.0.1"


}






