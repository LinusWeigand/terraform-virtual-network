resource "azurerm_mysql_server" "mysqlserver" {
  name                         = "${var.prefix}-app-mysqlserver"
  location                     = var.location
  resource_group_name          = azurerm_resource_group.global-prod-rg.name
  administrator_login          = "mysqladmin"
  administrator_login_password = var.dbpassword

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                = true
  backup_retention_days            = 7
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
  tags = {
    Environment = var.environment
  }
}

resource "azurerm_mysql_database" "mysqldb" {
  name                = "${var.prefix}-app-db"
  resource_group_name = azurerm_resource_group.global-prod-rg.name
  server_name         = azurerm_mysql_server.mysqlserver.name
  charset             = "utf8"
  collation           = "utf8_general_ci"
}
