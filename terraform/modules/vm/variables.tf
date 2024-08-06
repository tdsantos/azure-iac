variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
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

variable "vm_linux_ssh_key_path" {
  description = "The path to the SSH public key for the Linux virtual machine"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}
