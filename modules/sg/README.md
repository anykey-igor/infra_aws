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
| [aws_security_group.sg_alb_http_pl_asia](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sg_alb_http_pl_easteu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sg_alb_https_pl_asia](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sg_alb_https_pl_easteu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sg_ecs_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sg_ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment for service | `string` | `"DEMO"` | no |
| <a name="input_orchestration"></a> [orchestration](#input\_orchestration) | Type of Orchestration | `string` | `"tf"` | no |
| <a name="input_port"></a> [port](#input\_port) | The port on which the DB accepts connections | `any` | `null` | no |
| <a name="input_private_subnet_cidr"></a> [private\_subnet\_cidr](#input\_private\_subnet\_cidr) | List of private subnet cidr block | `any` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Name of Project | `string` | `"test"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tag blocks. Each element should have keys named key, value, and propagate\_at\_launch. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc\_id | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sg_alb_http_pl_asia_id"></a> [sg\_alb\_http\_pl\_asia\_id](#output\_sg\_alb\_http\_pl\_asia\_id) | n/a |
| <a name="output_sg_alb_http_pl_easteu_id"></a> [sg\_alb\_http\_pl\_easteu\_id](#output\_sg\_alb\_http\_pl\_easteu\_id) | n/a |
| <a name="output_sg_alb_https_pl_asia_id"></a> [sg\_alb\_https\_pl\_asia\_id](#output\_sg\_alb\_https\_pl\_asia\_id) | n/a |
| <a name="output_sg_alb_https_pl_easteu_id"></a> [sg\_alb\_https\_pl\_easteu\_id](#output\_sg\_alb\_https\_pl\_easteu\_id) | n/a |
| <a name="output_sg_database_ecs_id"></a> [sg\_database\_ecs\_id](#output\_sg\_database\_ecs\_id) | n/a |
| <a name="output_sg_ecs_service"></a> [sg\_ecs\_service](#output\_sg\_ecs\_service) | n/a |
