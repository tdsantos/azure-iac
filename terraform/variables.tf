variable "location" {
  description = "The location where the resources will be created"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-olimpiadas"
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "vnet-olimpiadas"
}

variable "address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet01_name" {
  description = "The name of the first subnet"
  type        = string
  default     = "sub-olimpiadas01"
}

variable "subnet01_prefix" {
  description = "The prefix of the first subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet02_name" {
  description = "The name of the second subnet"
  type        = string
  default     = "sub-olimpiadas02"
}

variable "subnet02_prefix" {
  description = "The prefix of the second subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "nsg_name" {
  description = "The name of the network security group"
  type        = string
  default     = "nsg-olimpiadas"
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
  default     = {
    Ambiente = "Olimpiadas"
  }
}

variable "vm_windows_username" {
  description = "Admin username for the Windows VM"
  type        = string
}

variable "vm_windows_password" {
  description = "Admin password for the Windows VM"
  type        = string
}

variable "vm_linux_username" {
  description = "Admin username for the Linux VM"
  type        = string
}

variable "vm_linux_password" {
  description = "Admin password for the Linux VM"
  type        = string
}

variable "vm_windows_size" {
  description = "Size of the Windows VM"
  type        = string
  default     = "Standard_DC2s_v3" # Atualizado para o tipo atual
}
