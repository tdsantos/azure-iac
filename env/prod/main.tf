module "network" {
  source = "../../modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "compute" {
  source = "../../modules/compute"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "storage" {
  source = "../../modules/storage"
  resource_group_name = var.resource_group_name
  location            = var.location
}
