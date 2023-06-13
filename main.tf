resource "azurerm_virtual_network" "network" {
  name                = "${var.resource_group_name}_network"
  address_space       = ["10.3.0.0/16"]
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet_internal" {
  name                 = "internal"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.3.1.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.resource_group_name}_public_ip"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = "Static"
}
