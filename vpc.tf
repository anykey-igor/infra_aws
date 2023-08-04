module "vpc" {
  source               = "modulespc"
  environment          = var.environment
  project              = var.project
  vpc_cidr             = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  public_subnet_cidr   = ["172.31.10.0/24", "172.31.11.0/24"]
  private_subnet_cidr  = ["172.31.20.0/24", "172.31.21.0/24"]
  enable_internet_gw   = true
  enable_nat_gw        = false
  single_nat_gw        = false
  enable_eip           = false
}