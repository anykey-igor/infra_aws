module "sg_backend" {
  source              = "modulesg"
  project             = var.project
  environment         = var.environment
  orchestration       = var.orchestration
  vpc_id              = module.vpc.vpc_id
  private_subnet_cidr = module.vpc.private_subnets_cidr_blocks
  port                = 3306
}