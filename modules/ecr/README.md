## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.ecr_lifecycle_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.ecr_repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.ecr_repository_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [template_file.lifecycle_policy](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.policy](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecr_lifecycle_policy"></a> [ecr\_lifecycle\_policy](#input\_ecr\_lifecycle\_policy) | Json file with lifecycle policy | `string` | `""` | no |
| <a name="input_ecr_lifecycle_policy_repository"></a> [ecr\_lifecycle\_policy\_repository](#input\_ecr\_lifecycle\_policy\_repository) | Set repository for lifecycle policy resource | `string` | `""` | no |
| <a name="input_ecr_policy_repository"></a> [ecr\_policy\_repository](#input\_ecr\_policy\_repository) | (Required) Name of the repository to apply the policy. | `string` | `""` | no |
| <a name="input_ecr_repo_encryption_type"></a> [ecr\_repo\_encryption\_type](#input\_ecr\_repo\_encryption\_type) | (Optional) The encryption type to use for the repository. Valid values are AES256 or KMS. Defaults to AES256 | `string` | `"AES256"` | no |
| <a name="input_ecr_repo_name"></a> [ecr\_repo\_name](#input\_ecr\_repo\_name) | (Required) Name of the repository. | `string` | `""` | no |
| <a name="input_ecr_repo_policy_template"></a> [ecr\_repo\_policy\_template](#input\_ecr\_repo\_policy\_template) | Json file with policy | `string` | `""` | no |
| <a name="input_ecr_repo_scan_images"></a> [ecr\_repo\_scan\_images](#input\_ecr\_repo\_scan\_images) | (Optional) Configuration block that defines image scanning configuration for the repository. By default, image scanning must be manually triggered. | `bool` | `false` | no |
| <a name="input_enable_ecr_lifecycle_policy"></a> [enable\_ecr\_lifecycle\_policy](#input\_enable\_ecr\_lifecycle\_policy) | Enable ecr lifecycle policy | `bool` | `false` | no |
| <a name="input_enable_ecr_repo"></a> [enable\_ecr\_repo](#input\_enable\_ecr\_repo) | Enable ecr repo creating | `bool` | `false` | no |
| <a name="input_enable_ecr_repo_policy"></a> [enable\_ecr\_repo\_policy](#input\_enable\_ecr\_repo\_policy) | Enable ecr repo policy usage | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment for service | `string` | `"DEMO"` | no |
| <a name="input_image_tag_mutability"></a> [image\_tag\_mutability](#input\_image\_tag\_mutability) | (Optional) The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE. Defaults to MUTABLE | `string` | `"MUTABLE"` | no |
| <a name="input_orchestration"></a> [orchestration](#input\_orchestration) | Type of Orchestration | `string` | `"tf"` | no |
| <a name="input_project"></a> [project](#input\_project) | Name of Project | `string` | `"test"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tag blocks. Each element should have keys named key, value, and propagate\_at\_launch. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_ecr_repository_arn"></a> [aws\_ecr\_repository\_arn](#output\_aws\_ecr\_repository\_arn) | Full ARN of the repository. |
| <a name="output_aws_ecr_repository_name"></a> [aws\_ecr\_repository\_name](#output\_aws\_ecr\_repository\_name) | The name of the repository. |
| <a name="output_aws_ecr_repository_registry_id"></a> [aws\_ecr\_repository\_registry\_id](#output\_aws\_ecr\_repository\_registry\_id) | The registry ID where the repository was created. |
| <a name="output_aws_ecr_repository_url"></a> [aws\_ecr\_repository\_url](#output\_aws\_ecr\_repository\_url) | The URL of the repository (in the form aws\_account\_id.dkr.ecr.region.amazonaws.com/repositoryName |
