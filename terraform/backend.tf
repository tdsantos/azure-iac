terraform {
  backend "azurerm" {
    resource_group_name  = "rg-olimpiadas"
    storage_account_name = "terraformazureclistate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
