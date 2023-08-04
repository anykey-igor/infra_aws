locals {
  hosted_zone_dash = "${replace(var.domain_name, ".", "-")}"
  origin_bucket    = "${local.hosted_zone_dash}-origin"
  log_bucket       = "${local.hosted_zone_dash}-cloudfront-log"
}

# create S3 Bucket:
resource "aws_s3_bucket" "frontend_bucket" {
  bucket = local.hosted_zone_dash

  tags = merge(
    {
      Name = "${lower(var.project)}-${local.hosted_zone_dash}-${var.orchestration}-${lower(var.environment)}"
    },
    var.tags
  )
  force_destroy = true
}

# block public access :
resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.frontend_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

# encrypt bucket using SSE-S3:
resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt" {
  bucket = aws_s3_bucket.frontend_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#creating OAI :
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for ${var.domain_name}"

}

#creating CF distribution :
resource "aws_cloudfront_distribution" "frontend_dist" {

  enabled             = true
  aliases             = [var.domain_name]
  default_root_object = "index.html"
  logging_config {
    bucket = "dev-s3-cloudfront-logs.s3.amazonaws.com"
    include_cookies = true
    prefix = "423453031423/E162134IRRY1DW32/" #get from resource
  }
  origin {
    domain_name = aws_s3_bucket.frontend_bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.frontend_bucket.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }
  custom_error_response {
    error_code = 403
    response_code = 200
    response_page_path = "/index.html"
    error_caching_min_ttl = 1
  }
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = aws_s3_bucket.frontend_bucket.id
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      headers      = []
      query_string = true

      cookies {
        forward = "all"
      }
    }

  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
      #locations        = ["IN", "US", "CA"]
    }
  }
  price_class = "PriceClass_All"
  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn      = var.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
  tags = merge(
    {
      Name = "${lower(var.project)}-dist-${var.orchestration}-${lower(var.environment)}"
    },
    var.tags
  )
}

data "aws_iam_policy_document" "this" {
  version = "2008-10-17"
  policy_id = "PolicyForCloudFrontPrivateContent"
  statement {
    sid = "AllowCloudFrontServicePrincipal"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.frontend_bucket.arn}/*"] #format("arn:aws:s3:::%s/*", local.hosted_zone_dash)]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.frontend_dist.arn] #[format("arn:aws:cloudfront::%s:distribution/%s", data.aws_caller_identity.this.account_id, aws_cloudfront_distribution.frontend_dist.id)]
    }
  }
  statement {
    sid    = "2"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.oai.iam_arn}"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.frontend_bucket.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = local.hosted_zone_dash
  policy = data.aws_iam_policy_document.this.json
}