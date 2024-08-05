variable "location" {
  description = "The location where the resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "vm_linux_username" {
  description = "The admin username for the Linux VM"
  type        = string
  default     = "johnsnow"
}

variable "vm_linux_password" {
  description = "The admin password for the Linux VM"
  type        = string
  default     = "partiuNuvem2024"
}

variable "vm_windows_username" {
  description = "The admin username for the Windows VM"
  type        = string
  default     = "johnsnow"
}

variable "vm_windows_password" {
  description = "The admin password for the Windows VM"
  type        = string
  default     = "partiuNuvem2024"
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default     = {}
}

variable "vm_windows_size" {
  description = "The size of the Windows virtual machine"
  type        = string
  default     = "Standard_B2s"
}

variable "vm_linux_size" {
  description = "The size of the Linux virtual machine"
  type        = string
  default     = "Standard_B2s"
}
