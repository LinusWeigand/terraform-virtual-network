# App Service Plan North
resource "azurerm_app_service_plan" "north-asp" {
  name                = "${var.prefix}-north-asp"
  location            = azurerm_resource_group.north-prod-rg.location
  resource_group_name = azurerm_resource_group.north-prod-rg.name
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
  name                = "${var.prefix}-north-java-appservice"
  location            = azurerm_resource_group.north-prod-rg.location
  resource_group_name = azurerm_resource_group.north-prod-rg.name
  app_service_plan_id = azurerm_app_service_plan.north-asp.id

  site_config {
    java_version           = "1.8"
    java_container         = "TOMCAT"
    java_container_version = "9.0"
  }

  tags = {
    Environment = var.environment
  }

  connection_string {
    name  = "Database"
    type  = "MySQL"
    value = "Server=${var.prefix}-app-mysqlserver;Port=3306;Database=${var.prefix}-app-db;User=mysqladmin;SSLMode=1;UseSystemTrustStore=0;Password=${var.dbpassword};"
  }

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY       = azurerm_application_insights.north-appinsights.instrumentation_key
    APPINSIGHTINSIGHTS_CONNECTION_STRING = azurerm_application_insights.north-appinsights.connection_string
  }
}

# App Service West
resource "azurerm_app_service" "west-appservice" {
  name                = "${var.prefix}-west-java-appservice"
  location            = azurerm_resource_group.west-prod-rg.location
  resource_group_name = azurerm_resource_group.west-prod-rg.name
  app_service_plan_id = azurerm_app_service_plan.west-asp.id

  site_config {
    java_version           = "1.8"
    java_container         = "TOMCAT"
    java_container_version = "9.0"
  }

  tags = {
    Environment = var.environment
  }

  connection_string {
    name  = "Database"
    type  = "MySQL"
    value = "Server=${var.prefix}-app-mysqlserver;Port=3306;Database=${var.prefix}-app-db;User=mysqladmin;SSLMode=1;UseSystemTrustStore=0;Password=${var.dbpassword};"
  }

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY       = azurerm_application_insights.west-appinsights.instrumentation_key
    APPINSIGHTINSIGHTS_CONNECTION_STRING = azurerm_application_insights.west-appinsights.connection_string
  }
}
