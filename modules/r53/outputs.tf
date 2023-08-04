output "domain_summary" {
  value = try(data.aws_route53_zone.this, "")
}
output "domain_id" {
  value = data.aws_route53_zone.this.id
}
output "domain_arn" {
  value = data.aws_route53_zone.this.arn
}
output "domain_zone_id" {
  value = data.aws_route53_zone.this.zone_id
}
output "domain_name" {
  value = data.aws_route53_zone.this.name
}