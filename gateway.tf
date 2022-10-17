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
    subnet_id = azurerm_subnet.north_subnet.id
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


}
