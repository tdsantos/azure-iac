terraform {
  backend "azurerm" {
    resource_group_name  = "<SEU_RESOURCE_GROUP>"
    storage_account_name = "<SEU_STORAGE_ACCOUNT>"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
