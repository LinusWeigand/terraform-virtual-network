# Create a resource group north
resource "azurerm_resource_group" "north-prod-rg" {
  name     = "${var.prefix}-north-resources"
  location = "North Europe"

  tags = {
    Environment = var.environment
  }
}

# Create a resource group west
resource "azurerm_resource_group" "west-prod-rg" {
  name     = "${var.prefix}-west-resources"
  location = "West Europe"

  tags = {
    Environment = var.environment
  }
}

# Create a resource group global
resource "azurerm_resource_group" "global-prod-rg" {
  name     = "${var.prefix}-global-rg"
  location = "Germany West Central"

  tags = {
    Environment = var.environment
  }
}
