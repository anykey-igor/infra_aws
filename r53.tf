module "r53" { #backend
  source       = "modules53"
  domain_name  = var.domain_name
  sub_domain_name = var.backend_url
  resource_dns_name = module.alb.alb_dns_name
  resource_zone_id  = module.alb.alb_zone_id
}
module "r53_frontend" {
  source       = "modules53"
  domain_name  = var.domain_name
  sub_domain_name = var.frontend_url
  resource_dns_name = module.frontend.cloudfront_dist_domain_name
  resource_zone_id  = module.frontend.cloudfront_dist_zone_id
}