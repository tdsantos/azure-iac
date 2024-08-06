variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
}

variable "subnet01_name" {
  description = "The name of the first subnet"
  type        = string
}

variable "subnet01_prefix" {
  description = "The address prefix of the first subnet"
  type        = string
}

variable "subnet02_name" {
  description = "The name of the second subnet"
  type        = string
}

variable "subnet02_prefix" {
  description = "The address prefix of the second subnet"
  type        = string
}

variable "nsg_name" {
  description = "The name of the network security group"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}

variable "vm_windows_name" {
  description = "The name of the Windows virtual machine"
  type        = string
}

variable "vm_windows_username" {
  description = "The admin username for the Windows virtual machine"
  type        = string
}

variable "vm_windows_password" {
  description = "The admin password for the Windows virtual machine"
  type        = string
  sensitive   = true
}

variable "vm_linux_name" {
  description = "The name of the Linux virtual machine"
  type        = string
}

variable "vm_linux_username" {
  description = "The admin username for the Linux virtual machine"
  type        = string
}

variable "vm_linux_password" {
  description = "The admin password for the Linux virtual machine"
  type        = string
  sensitive   = true
}

variable "vm_linux_ssh_key_path" {
  description = "The path to the SSH public key for the Linux virtual machine"
  type        = string
}
