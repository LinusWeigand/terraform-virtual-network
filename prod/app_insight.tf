resource "azurerm_application_insights" "north_appinsights" {
  name                = "${var.prefix}-north-appinsights"
  location            = var.location
  resource_group_name = azurerm_resource_group.north-prod-rg.name
  application_type    = "java"
}

output "instrumentation_key_north" {
  value     = azurerm_application_insights.north_appinsights.instrumentation_key
  sensitive = true
}

output "app_id_north" {
  value = azurerm_application_insights.north_appinsights.app_id
}

resource "azurerm_application_insights" "west_appinsights" {
  name                = "${var.prefix}-west-appinsights"
  location            = var.location
  resource_group_name = azurerm_resource_group.west-prod-rg.name
  application_type    = "java"
}

output "instrumentation_key_west" {
  value     = azurerm_application_insights.west_appinsights.instrumentation_key
  sensitive = true
}

output "app_id_west" {
  value = azurerm_application_insights.west_appinsights.app_id
}
