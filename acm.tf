provider "aws" {
  alias  = "useast1"
  region = "us-east-1"
}

module "acm_frontend" {
  source         = "modulescm"
  domain_name    = "${lower(var.frontend_url)}.${var.domain_name}"
  domain_zone_id = module.r53.domain_zone_id
  providers      = {
    aws = aws.useast1
  }

}
module "acm_backend" {
  source         = "modulescm"
  domain_name    = "${var.backend_url}.${var.domain_name}"
  domain_zone_id = module.r53.domain_zone_id
}