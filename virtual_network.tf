# Virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = "tstate"
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = "tstate"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Public IP
resource "azurerm_public_ip" "publicip" {
  name                = "pip1"
  location            = var.location
  resource_group_name = "tstate"
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

# Network interface
resource "azurerm_network_interface" "nic" {
  name                = "${var.prefix}-nic"
  location            = var.location
  resource_group_name = "tstate"

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

# Security group
resource "azurerm_network_security_group" "frontendnsg" {
  name                = "${var.prefix}-SecurityGroup"
  location            = var.location
  resource_group_name = "tstate"

  security_rule {
    environmemt = "Production"
  }
}

# Security rules
resource "azurerm_network_security_rule" "httprule" {
  name                        = "${var.prefix}-http"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8080"
  source_address_prefix       = "*"
  destination_address_prefix  = "10.0.1.0/24"
  resource_group_name         = "tstate"
  network_security_group_name = azurerm_network_security_group.frontendnsg.name
}

resource "azurerm_network_security_rule" "sshrule" {
  name                        = "${var.prefix}-ssh"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "10.0.1.0/24"
  resource_group_name         = "tstate"
  network_security_group_name = azurerm_network_security_group.frontendnsg.name
}
