resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "subnet01" {
  name                 = var.subnet01_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet01_prefix]
}

resource "azurerm_subnet" "subnet02" {
  name                 = var.subnet02_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet02_prefix]
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet01_id" {
  value = azurerm_subnet.subnet01.id
}

output "subnet02_id" {
  value = azurerm_subnet.subnet02.id
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}
