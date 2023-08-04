## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.frontend_dist](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.oai](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_s3_bucket.frontend_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.public_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.encrypt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | n/a | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment for service | `string` | `"DEMO"` | no |
| <a name="input_orchestration"></a> [orchestration](#input\_orchestration) | Type of Orchestration | `string` | `"tf"` | no |
| <a name="input_project"></a> [project](#input\_project) | Name of Project | `string` | `"test"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tag blocks. Each element should have keys named key, value, and propagate\_at\_launch. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudfront_dist_domain_name"></a> [cloudfront\_dist\_domain\_name](#output\_cloudfront\_dist\_domain\_name) | n/a |
| <a name="output_cloudfront_dist_prefix"></a> [cloudfront\_dist\_prefix](#output\_cloudfront\_dist\_prefix) | n/a |
| <a name="output_cloudfront_dist_zone_id"></a> [cloudfront\_dist\_zone\_id](#output\_cloudfront\_dist\_zone\_id) | n/a |
| <a name="output_dist_arn"></a> [dist\_arn](#output\_dist\_arn) | n/a |
| <a name="output_oai_arn"></a> [oai\_arn](#output\_oai\_arn) | n/a |
