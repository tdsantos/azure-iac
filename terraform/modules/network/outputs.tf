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
