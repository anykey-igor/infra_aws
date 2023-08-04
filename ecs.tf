module "ecs" {
  source                    = "modulescs"
  vpc_id                    = module.vpc.vpc_id
  project                   = var.project
  environment               = var.environment
  subnets                   = module.vpc.public_subnets
  aws_alb_target_group_arn  = module.alb.aws_alb_target_group_arn
  sg_ecs                    = [module.sg_backend.sg_ecs_service]
  max_capacity_service_task = var.max_capacity_service_task
  min_capacity_service_task = var.min_capacity_service_task
}