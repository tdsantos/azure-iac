
# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

# Subnets
resource "azurerm_subnet" "subnet01" {
  name                 = var.subnet01_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet01_prefix]
}

resource "azurerm_subnet" "subnet02" {
  name                 = var.subnet02_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet02_prefix]
}

# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

# Public IP for Linux VM
resource "azurerm_public_ip" "pip_linux" {
  name                = "${var.vm_linux_name}-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

# Public IP for Windows VM
resource "azurerm_public_ip" "pip_windows" {
  name                = "${var.vm_windows_name}-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

# Network Interface for Windows VM
resource "azurerm_network_interface" "nic_windows" {
  name                = "${var.vm_windows_name}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_windows.id
  }
}

# Network Interface for Linux VM
resource "azurerm_network_interface" "nic_linux" {
  name                = "${var.vm_linux_name}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet02.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_linux.id
  }
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "vm_linux" {
  name                = var.vm_linux_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  network_interface_ids = [
    azurerm_network_interface.nic_linux.id,
  ]
  size           = "Standard_DC2s_v3"
  admin_username = var.vm_linux_username

  admin_ssh_key {
    username   = var.vm_linux_username
    public_key = file(var.vm_linux_ssh_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-minimal-focal"
    sku       = "minimal-20_04-lts-gen2"
    version   = "latest"
  }

  tags = var.tags
}

# Windows Virtual Machine
resource "azurerm_windows_virtual_machine" "vm_windows" {
  name                = var.vm_windows_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  network_interface_ids = [
    azurerm_network_interface.nic_windows.id,
  ]
  size           = "Standard_DC2s_v3"
  admin_username = var.vm_windows_username
  admin_password = var.vm_windows_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  tags = var.tags
}
