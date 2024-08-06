module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnet01_name       = var.subnet01_name
  subnet01_prefix     = var.subnet01_prefix
  subnet02_name       = var.subnet02_name
  subnet02_prefix     = var.subnet02_prefix
  nsg_name            = var.nsg_name
  tags                = var.tags
}

module "vm" {
  source              = "./modules/vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = module.network.subnet01_id
  vm_windows_name     = var.vm_windows_name
  vm_windows_username = var.vm_windows_username
  vm_windows_password = var.vm_windows_password
  vm_linux_name       = var.vm_linux_name
  vm_linux_username   = var.vm_linux_username
  vm_linux_password   = var.vm_linux_password
  tags                = var.tags
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "subnet01_id" {
  value = module.network.subnet01_id
}

output "subnet02_id" {
  value = module.network.subnet02_id
}

output "nsg_id" {
  value = module.network.nsg_id
}
