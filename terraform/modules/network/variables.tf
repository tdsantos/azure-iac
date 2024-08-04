variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location where resources will be created"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "subnet01_name" {
  description = "The name of the first subnet"
  type        = string
}

variable "subnet01_prefix" {
  description = "The address prefix for the first subnet"
  type        = string
}

variable "subnet02_name" {
  description = "The name of the second subnet"
  type        = string
}

variable "subnet02_prefix" {
  description = "The address prefix for the second subnet"
  type        = string
}

variable "nsg_name" {
  description = "The name of the network security group"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
}
