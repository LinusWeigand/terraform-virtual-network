# Traffic Manager for Java Web App
resource "azurerm_traffic_manager_profile" "traffic_manager" {
  name                   = "${var.prefix}-java-webapp-tm"
  resource_group_name    = azurerm_resource_group.global-prod-rg.name
  traffic_routing_method = "Performance"
  dns_config {
    relative_name = "${var.prefix}-java-webapp"
    ttl           = 300
  }

  monitor_config {
    protocol                      = "http"
    port                          = 80
    path                          = "/"
    interval_in_seconds           = 30
    timeout_in_seconds            = 9
    toleraterd_number_of_failures = 3
  }

  tags = {
    Environment = var.environment
  }
}

# Endpoint North
resource "azurerm_traffic_manager_endpoint" "north-tm-enpoint" {
  name                = "${var.prefix}-north-global-tm"
  resource_group_name = azurerm_resource_group.global-prod-rg.name
  profile_name        = azurerm_traffic_manager_profile.traffic_manager.name
  target              = azurerm_public_ip.north-publicip.fqdn
  endpoint_location   = azurerm_public_ip.north-publicip.location
  type                = "externalEndpoints"
}

# Endpoint West
resource "azurerm_traffic_manager_endpoint" "west-tm-enpoint" {
  name                = "${var.prefix}-west-global-tm"
  resource_group_name = azurerm_resource_group.global-prod-rg.name
  profile_name        = azurerm_traffic_manager_profile.traffic_manager.name
  target              = azurerm_public_ip.west-publicip.fqdn
  endpoint_location   = azurerm_public_ip.west-publicip.location
  type                = "externalEndpoints"
}
