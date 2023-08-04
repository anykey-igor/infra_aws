module "alb" {
  source              = "moduleslb"
  project             = var.project
  environment         = var.environment
  orchestration       = var.orchestration
  vpc_id              = module.vpc.vpc_id
  subnets             = module.vpc.public_subnets
  certificate_backend = module.acm_backend.acm_certificate_arn
  alb_sg_list         = [
    module.sg_backend.sg_alb_http_pl_asia_id,
    module.sg_backend.sg_alb_http_pl_easteu_id,
    module.sg_backend.sg_alb_https_pl_asia_id,
    module.sg_backend.sg_alb_https_pl_easteu_id]
}