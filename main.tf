module "rg" {
  source            = "./modules/resource-group"
  RGNAME            = var.RGNAME
  LOCATION          = var.LOCATION
}

module "network" {
  source            = "./modules/network"
  LOCATION          = module.rg.LOCATION
  NETWORK_CIDR      = var.NETWORK_CIDR
  RGNAME            = module.rg.RGNAME
  SUBNET_CIDRS      = var.SUBNET_CIDRS
}

module "aks" {
  source            = "./modules/aks"
  LOCATION          = module.rg.LOCATION
  RGNAME            = module.rg.RGNAME
  SUBNETS           = module.network.SUBNETS
}
