module "frontend" {
  source          = "modulesloudfront"
  project         = var.project
  environment     = var.environment
  domain_name     = "${lower(var.frontend_url)}.${lower(var.domain_name)}"
  certificate_arn = module.acm_frontend.acm_certificate_arn
}