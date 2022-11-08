# Azure Provider source and version being used 
terraform {
  backend "azurerm" {
    resource_group_name  = "tstate"
    storage_account_name = "tstate982"
    container_name       = "tstate"
    key                  = "terraform_app_service.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.46.0"
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
