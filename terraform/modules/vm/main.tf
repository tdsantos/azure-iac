resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
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
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  subnet_id           = module.network.subnet01_id
  vm_windows_name     = var.vm_windows_name
  vm_windows_username = var.vm_windows_username
  vm_windows_password = var.vm_windows_password
  vm_linux_name       = var.vm_linux_name
  vm_linux_username   = var.vm_linux_username
  vm_linux_ssh_key_path = var.vm_linux_ssh_key_path
  tags                = var.tags
}

resource "azurerm_linux_virtual_machine" "vm_linux" {
  name                = var.vm_linux_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_DC2s_v3"
  admin_username      = var.vm_linux_username
  disable_password_authentication = true
  network_interface_ids = [module.network.subnet02_id]
  
  admin_ssh_key {
    username   = var.vm_linux_username
    public_key = file(var.vm_linux_ssh_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-minimal-focal"
    sku       = "minimal-20_04-lts-gen2"
    version   = "latest"
  }

  tags = var.tags
}
