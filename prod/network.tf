# Virtual network North
resource "azurerm_virtual_network" "north-vnet" {
  name                = "${var.prefix}-north-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.north-prod-rg.location
  resource_group_name = azurerm_resource_group.global-prod-rg.name
}

# Virtual network West
resource "azurerm_virtual_network" "west_vnet" {
  name                = "${var.prefix}-west-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.west-prod-rg.location
  resource_group_name = azurerm_resource_group.west-prod-rg.name
}

# ---------------------------------------- #

# Subnet North
resource "azurerm_subnet" "north_subnet" {
  name                 = "${var.prefix}-north-subnet"
  resource_group_name  = azurerm_resource_group.north-prod-rg.name
  virtual_network_name = azurerm_virtual_network.north-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Subnet West
resource "azurerm_subnet" "west_subnet" {
  name                 = "${var.prefix}-west-subnet"
  resource_group_name  = azurerm_resource_group.west-prod-rg.name
  virtual_network_name = azurerm_virtual_network.west-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# ---------------------------------------- #

# Public IP North
resource "azurerm_public_ip" "north-publicip" {
  name                = "${var.prefix}-north-pip"
  location            = azurerm_resource_group.north-prod-rg.location
  resource_group_name = azurerm_resource_group.north-prod-rg.name
  allocation_method   = "Dynamic"
}

# Public IP West
resource "azurerm_public_ip" "west-publicip" {
  name                = "${var.prefix}-west-pip"
  location            = azurerm_resource_group.west-prod-rg.location
  resource_group_name = azurerm_resource_group.west-prod-rg.name
  allocation_method   = "Dynamic"
}
