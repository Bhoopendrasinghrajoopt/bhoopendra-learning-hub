terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.81.0"
    }
  }
  backend "azurerm" {

    resource_group_name  = "rg-jumlebaaz"
    storage_account_name = "jumlebaaz12131415"
    container_name       = "tfstate"
    key                  = "preprod.tfstate"

  }
}
provider "azurerm" {
  features {

  }
}