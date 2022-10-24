# App Gateway North
resource "azurerm_application_gateway" "north-gateway" {
  name                = "${var.prefix}-north-appgateway"
  location            = azurerm_resource_group.north-prod-rg.location
  resource_group_name = azurerm_resource_group.north-prod-rg.name
  sku {
    name     = "WAF_Medium"
    tier     = "WAF"
    capacity = 2
  }

  waf_configuration {
    enabled          = "true"
    firewall_mode    = "Detection"
    rule_set_type    = "OWASP"
    rule_set_version = "3.0"
  }

  gateway_ip_configuration {
    name      = "${var.prefix}-north-gateway-ip-configuration"
    subnet_id = azurerm_subnet.north-subnet.id
  }

  frontend_port {
    name = "${azurerm_virtual_network.north-vnet.name}-feport"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "${azurerm_virtual_network.north-vnet.name}-feip"
    public_ip_address_id = azurerm_public_ip.north-publicip.id
  }

  backend_address_pool {
    name  = "${azurerm_virtual_network.north-vnet.name}-beap"
    fqdns = ["${azurerm_app_service.north-appservice.name}.azurewebsites.net"]
  }

  probe {
    name                = "north-probe"
    protocol            = "http"
    path                = "/"
    host                = "${azurerm_app_service.north-appservice.name}.azurewebsites.net"
    interval            = "30"
    timeout             = "30"
    unhealthy_threshold = "3"
  }

  backend_http_settings {
    name                                = "${azurerm_virtual_network.north-vnet.name}-be-htst"
    cookie_based_affinity               = "Disabled"
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 60
    probe_name                          = "north-probe"
    pick_host_name_from_backend_address = true
  }

  http_listener {
    name                           = "${azurerm_virtual_network.north-vnet.name}-httplstn"
    frontend_ip_configuration_name = "${azurerm_virtual_network.north-vnet.name}-feip"
    frontend_port_name             = "${azurerm_virtual_network.north-vnet.name}-feport"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${azurerm_virtual_network.north-vnet.name}-rqrt"
    rule_type                  = "Basic"
    http_listener_name         = "${azurerm_virtual_network.north-vnet.name}-httplstn"
    backend_address_pool_name  = "${azurerm_virtual_network.north-vnet.name}-beap"
    backend_http_settings_name = "${azurerm_virtual_network.north-vnet.name}-be-htst"
  }

  tags = {
    environment = var.environment
  }
}

# App Gateway West
resource "azurerm_application_gateway" "west-gateway" {
  name                = "${var.prefix}-west-appgateway"
  location            = azurerm_resource_group.west-prod-rg.location
  resource_group_name = azurerm_resource_group.west-prod-rg.name
  sku {
    name     = "WAF_Medium"
    tier     = "WAF"
    capacity = 2
  }

  waf_configuration {
    enabled          = "true"
    firewall_mode    = "Detection"
    rule_set_type    = "OWASP"
    rule_set_version = "3.0"
  }

  gateway_ip_configuration {
    name      = "${var.prefix}-west-gateway-ip-configuration"
    subnet_id = azurerm_subnet.west-subnet.id
  }

  frontend_port {
    name = "${azurerm_virtual_network.west-vnet.name}-feport"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "${azurerm_virtual_network.west-vnet.name}-feip"
    public_ip_address_id = azurerm_public_ip.west-publicip.id
  }

  backend_address_pool {
    name  = "${azurerm_virtual_network.west-vnet.name}-beap"
    fqdns = ["${azurerm_app_service.west-appservice.name}.azurewebsites.net"]
  }

  probe {
    name                = "west-probe"
    protocol            = "http"
    path                = "/"
    host                = "${azurerm_app_service.west-appservice.name}.azurewebsites.net"
    interval            = "30"
    timeout             = "30"
    unhealthy_threshold = "3"
  }

  backend_http_settings {
    name                                = "${azurerm_virtual_network.west-vnet.name}-be-htst"
    cookie_based_affinity               = "Disabled"
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 60
    probe_name                          = "west-probe"
    pick_host_name_from_backend_address = true
  }

  http_listener {
    name                           = "${azurerm_virtual_network.west-vnet.name}-httplstn"
    frontend_ip_configuration_name = "${azurerm_virtual_network.west-vnet.name}-feip"
    frontend_port_name             = "${azurerm_virtual_network.west-vnet.name}-feport"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${azurerm_virtual_network.west-vnet.name}-rqrt"
    rule_type                  = "Basic"
    http_listener_name         = "${azurerm_virtual_network.west-vnet.name}-httplstn"
    backend_address_pool_name  = "${azurerm_virtual_network.west-vnet.name}-beap"
    backend_http_settings_name = "${azurerm_virtual_network.west-vnet.name}-be-htst"
  }

  tags = {
    environment = var.environment
  }
}
