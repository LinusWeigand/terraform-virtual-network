# App Service Plan North
resource "azurerm_app_service_plan" "north-asp" {
  name                = "${var.prefix}-north-asp"
  location            = azurerm_resource_group.north-prod-rg.location
  resource_group_name = azurerm_resource_group.north-prod-rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = {
    Environment = var.environment
  }
}

# App Service Plan West
resource "azurerm_app_service_plan" "west-asp" {
  name                = "${var.prefix}-west-asp"
  location            = azurerm_resource_group.west-prod-rg.location
  resource_group_name = azurerm_resource_group.west-prod-rg.name
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = {
    Environment = var.environment
  }
}

# App Service North
resource "azurerm_app_service" "north_appservice" {
  name                = "${var.prefix}-north-appservice"
  location            = azurerm_resource_group.north-prod-rg.location
  resource_group_name = azurerm_resource_group.north-prod-rg.name
  app_service_plan_id = azurerm_app_service_plan.north-asp.id

  site_config {
    use_32_bit_worker_process = true
    linux_fx_version          = "NODE|12-lts"
  }

  tags = {
    Environment = var.environment
  }

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY       = azurerm_application_insights.north-appinsights.instrumentation_key
    APPINSIGHTINSIGHTS_CONNECTION_STRING = azurerm_application_insights.north-appinsights.connection_string
  }
}

# App Service West
resource "azurerm_app_service" "west-appservice" {
  name                = "${var.prefix}-west-appservice"
  location            = azurerm_resource_group.west-prod-rg.location
  resource_group_name = azurerm_resource_group.west-prod-rg.name
  app_service_plan_id = azurerm_app_service_plan.west-asp.id

  site_config {
    use_32_bit_worker_process = true
    linux_fx_version          = "NODE|12-lts"
  }

  tags = {
    Environment = var.environment
  }

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY       = azurerm_application_insights.west-appinsights.instrumentation_key
    APPINSIGHTINSIGHTS_CONNECTION_STRING = azurerm_application_insights.west-appinsights.connection_string
  }
}
