data "aws_route53_zone" "this" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "myRecord" {
  zone_id = data.aws_route53_zone.this.zone_id
  name = "${var.sub_domain_name}.${var.domain_name}"
  type = "A"

  alias {
    name = var.resource_dns_name
    zone_id = var.resource_zone_id
    evaluate_target_health = true
  }
}