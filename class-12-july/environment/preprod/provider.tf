terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.81.0"
    }
  }
  backend "azurerm" {

    resource_group_name  = "terraform-backend-rg"
    storage_account_name = "terraformstate123"
    container_name       = "tfstate"
    key                  = "preprod.tfstate"

  }
}
provider "azurerm" {
  features {

  }
}