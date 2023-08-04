output "cloudfront_dist_domain_name" {
  value = aws_cloudfront_distribution.frontend_dist.domain_name
}
output "cloudfront_dist_zone_id" {
  value = aws_cloudfront_distribution.frontend_dist.hosted_zone_id
}
output "cloudfront_dist_prefix" {
  value = aws_cloudfront_distribution.frontend_dist.id
}
output "dist_arn" {
  value = aws_cloudfront_distribution.frontend_dist.arn
}
output "oai_arn" {
  value = aws_cloudfront_origin_access_identity.oai.iam_arn
}