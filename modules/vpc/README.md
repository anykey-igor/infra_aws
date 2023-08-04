## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
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
| [aws_db_subnet_group.database_subnet_group_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private_route_tables](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_route_tables](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_route_table_associations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_route_table_associations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.cloud_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone_id"></a> [availability\_zone\_id](#input\_availability\_zone\_id) | (Optional) The AZ ID of the subnet. | `any` | `null` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | A list of Availability zones in the region | `list(string)` | `[]` | no |
| <a name="input_availability_zones_list"></a> [availability\_zones\_list](#input\_availability\_zones\_list) | A list of Availability zones in the region | `map` | <pre>{<br>  "eu-central-1": [<br>    "eu-central-1a",<br>    "eu-central-1b",<br>    "eu-central-1c"<br>  ],<br>  "us-east-1": [<br>    "us-east-1a",<br>    "us-east-1b",<br>    "us-east-1c",<br>    "us-east-1d",<br>    "us-east-1e",<br>    "us-east-1f"<br>  ],<br>  "us-east-2": [<br>    "us-east-2a",<br>    "eu-east-2b",<br>    "eu-east-2c"<br>  ]<br>}</pre> | no |
| <a name="input_create_database_internet_gateway_route"></a> [create\_database\_internet\_gateway\_route](#input\_create\_database\_internet\_gateway\_route) | Controls if an internet gateway route for public database access should be created | `bool` | `false` | no |
| <a name="input_create_database_subnet_route_table"></a> [create\_database\_subnet\_route\_table](#input\_create\_database\_subnet\_route\_table) | Controls if separate route table for database should be created | `bool` | `false` | no |
| <a name="input_custom_route_table_associations_stack"></a> [custom\_route\_table\_associations\_stack](#input\_custom\_route\_table\_associations\_stack) | Set route table associations | `list` | `[]` | no |
| <a name="input_database_route_tables_name"></a> [database\_route\_tables\_name](#input\_database\_route\_tables\_name) | Set name for custom Route Tables | `string` | `""` | no |
| <a name="input_database_route_tables_propagating_vgws"></a> [database\_route\_tables\_propagating\_vgws](#input\_database\_route\_tables\_propagating\_vgws) | (Optional) A list of virtual gateways for propagation. | `any` | `null` | no |
| <a name="input_database_route_tables_route_ipv4"></a> [database\_route\_tables\_route\_ipv4](#input\_database\_route\_tables\_route\_ipv4) | The CIDR block of the route for IPv4. | `list` | `[]` | no |
| <a name="input_database_route_tables_route_ipv6"></a> [database\_route\_tables\_route\_ipv6](#input\_database\_route\_tables\_route\_ipv6) | (Optional) The Ipv6 CIDR block of the route. | `list` | `[]` | no |
| <a name="input_database_route_tables_vpc_id"></a> [database\_route\_tables\_vpc\_id](#input\_database\_route\_tables\_vpc\_id) | The VPC ID. | `string` | `""` | no |
| <a name="input_database_subnet_cidr"></a> [database\_subnet\_cidr](#input\_database\_subnet\_cidr) | CIDR list for DataBase Subnets | `list(string)` | `[]` | no |
| <a name="input_default_route_table_name"></a> [default\_route\_table\_name](#input\_default\_route\_table\_name) | Name to be used on the default route table | `string` | `null` | no |
| <a name="input_default_route_table_propagating_vgws"></a> [default\_route\_table\_propagating\_vgws](#input\_default\_route\_table\_propagating\_vgws) | List of virtual gateways for propagation | `list(string)` | `[]` | no |
| <a name="input_default_route_table_routes"></a> [default\_route\_table\_routes](#input\_default\_route\_table\_routes) | Configuration block of routes. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table#route | `list(map(string))` | `[]` | no |
| <a name="input_default_router_table_id"></a> [default\_router\_table\_id](#input\_default\_router\_table\_id) | default router table ID | `any` | `null` | no |
| <a name="input_enable_classiclink"></a> [enable\_classiclink](#input\_enable\_classiclink) | (Optional) A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the ClassicLink documentation for more information. Defaults false. Dedicated tenancy VPCs cannot be enabled for ClassicLink by default | `bool` | `false` | no |
| <a name="input_enable_custom_route_table_associations"></a> [enable\_custom\_route\_table\_associations](#input\_enable\_custom\_route\_table\_associations) | Enable custom route table associations usage | `bool` | `false` | no |
| <a name="input_enable_database_route_tables"></a> [enable\_database\_route\_tables](#input\_enable\_database\_route\_tables) | Enable database Route Tables | `bool` | `false` | no |
| <a name="input_enable_dhcp"></a> [enable\_dhcp](#input\_enable\_dhcp) | Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type | `bool` | `false` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | (Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false. | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | (Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults true. | `bool` | `true` | no |
| <a name="input_enable_eip"></a> [enable\_eip](#input\_enable\_eip) | Allow creation elastic eip | `bool` | `false` | no |
| <a name="input_enable_internet_gw"></a> [enable\_internet\_gw](#input\_enable\_internet\_gw) | Allow Internet GateWay to/from public network | `bool` | `false` | no |
| <a name="input_enable_nat_gw"></a> [enable\_nat\_gw](#input\_enable\_nat\_gw) | Allow Nat GateWay to/from private network | `bool` | `false` | no |
| <a name="input_enable_network_acl"></a> [enable\_network\_acl](#input\_enable\_network\_acl) | Enable network acl for VPC usage | `bool` | `false` | no |
| <a name="input_enable_network_acl_rule"></a> [enable\_network\_acl\_rule](#input\_enable\_network\_acl\_rule) | Enable VPC network acl rule usage | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment for service | `string` | `""` | no |
| <a name="input_instance_tenancy"></a> [instance\_tenancy](#input\_instance\_tenancy) | (Optional) A tenancy option for instances launched into the VPC | `string` | `"default"` | no |
| <a name="input_internet_gw_name"></a> [internet\_gw\_name](#input\_internet\_gw\_name) | Name for internet gw | `string` | `""` | no |
| <a name="input_internet_gw_vpc_id"></a> [internet\_gw\_vpc\_id](#input\_internet\_gw\_vpc\_id) | The VPC ID to create in. | `string` | `""` | no |
| <a name="input_manage_default_route_table"></a> [manage\_default\_route\_table](#input\_manage\_default\_route\_table) | Should be true to manage default route table | `bool` | `false` | no |
| <a name="input_name_database_subnet"></a> [name\_database\_subnet](#input\_name\_database\_subnet) | Name for DataBase subnets | `string` | `"Cloud_Database_subnet"` | no |
| <a name="input_name_private_subnet"></a> [name\_private\_subnet](#input\_name\_private\_subnet) | Name for private subnets | `string` | `"Cloud_Private_subnet"` | no |
| <a name="input_name_public_subnet"></a> [name\_public\_subnet](#input\_name\_public\_subnet) | Name for Public Subnets | `string` | `"Cloud_Public_subnet"` | no |
| <a name="input_nat_eip_associate_with_private_ip"></a> [nat\_eip\_associate\_with\_private\_ip](#input\_nat\_eip\_associate\_with\_private\_ip) | (Optional) A user specified primary or secondary private IP address to associate with the Elastic IP address. If no private IP address is specified, the Elastic IP address is associated with the primary private IP address. | `any` | `null` | no |
| <a name="input_nat_eip_instance"></a> [nat\_eip\_instance](#input\_nat\_eip\_instance) | (Optional) EC2 instance ID. | `any` | `null` | no |
| <a name="input_nat_eip_name"></a> [nat\_eip\_name](#input\_nat\_eip\_name) | Set name for NAT EIP | `string` | `""` | no |
| <a name="input_nat_eip_network_interface"></a> [nat\_eip\_network\_interface](#input\_nat\_eip\_network\_interface) | (Optional) Network interface ID to associate with. | `any` | `null` | no |
| <a name="input_nat_eip_vpc"></a> [nat\_eip\_vpc](#input\_nat\_eip\_vpc) | (Optional) Boolean if the EIP is in a VPC or not. | `bool` | `true` | no |
| <a name="input_nat_gw_connectivity_type"></a> [nat\_gw\_connectivity\_type](#input\_nat\_gw\_connectivity\_type) | (Optional) Connectivity type for the gateway. Valid values are private and public. Defaults to public | `string` | `"public"` | no |
| <a name="input_nat_gw_name"></a> [nat\_gw\_name](#input\_nat\_gw\_name) | Set name for NAT GW | `string` | `""` | no |
| <a name="input_network_acl_egress"></a> [network\_acl\_egress](#input\_network\_acl\_egress) | (Optional) Specifies an egress rule. Parameters defined below. This argument is processed in attribute-as-blocks mode. | `list` | `[]` | no |
| <a name="input_network_acl_ingress"></a> [network\_acl\_ingress](#input\_network\_acl\_ingress) | (Optional) Specifies an ingress rule. Parameters defined below. This argument is processed in attribute-as-blocks mode. | `list` | `[]` | no |
| <a name="input_network_acl_name"></a> [network\_acl\_name](#input\_network\_acl\_name) | Set name for VPC network acl | `string` | `""` | no |
| <a name="input_network_acl_rule_parameter"></a> [network\_acl\_rule\_parameter](#input\_network\_acl\_rule\_parameter) | Set NACLs rules. | `list` | <pre>[<br>  {<br>    "cidr_block": null,<br>    "egress": null,<br>    "from_port": null,<br>    "icmp_code": null,<br>    "icmp_type": null,<br>    "ipv6_cidr_block": null,<br>    "network_acl_id": null,<br>    "protocol": null,<br>    "rule_action": null,<br>    "rule_number": null,<br>    "to_port": null<br>  }<br>]</pre> | no |
| <a name="input_network_acl_subnet_ids"></a> [network\_acl\_subnet\_ids](#input\_network\_acl\_subnet\_ids) | (Optional) A list of Subnet IDs to apply the ACL to | `any` | `null` | no |
| <a name="input_network_acl_vpc_id"></a> [network\_acl\_vpc\_id](#input\_network\_acl\_vpc\_id) | Set vpc\_id for NACL | `string` | `""` | no |
| <a name="input_orchestration"></a> [orchestration](#input\_orchestration) | Type of Orchestration | `string` | `"tf"` | no |
| <a name="input_private_route_tables_name"></a> [private\_route\_tables\_name](#input\_private\_route\_tables\_name) | Set name for private route tables | `string` | `""` | no |
| <a name="input_private_route_tables_propagating_vgws"></a> [private\_route\_tables\_propagating\_vgws](#input\_private\_route\_tables\_propagating\_vgws) | A list of VGWs the private route table should propagate. | `any` | `null` | no |
| <a name="input_private_route_tables_route_ipv4"></a> [private\_route\_tables\_route\_ipv4](#input\_private\_route\_tables\_route\_ipv4) | The CIDR block of the route for IPv4. | `list` | `[]` | no |
| <a name="input_private_route_tables_route_ipv6"></a> [private\_route\_tables\_route\_ipv6](#input\_private\_route\_tables\_route\_ipv6) | (Optional) The Ipv6 CIDR block of the route. | `list` | `[]` | no |
| <a name="input_private_route_tables_vpc_id"></a> [private\_route\_tables\_vpc\_id](#input\_private\_route\_tables\_vpc\_id) | The VPC ID. | `string` | `""` | no |
| <a name="input_private_subnet_cidr"></a> [private\_subnet\_cidr](#input\_private\_subnet\_cidr) | CIDR list for Private Subnets | `list(string)` | `[]` | no |
| <a name="input_project"></a> [project](#input\_project) | Name of Project | `string` | `"parkingApp"` | no |
| <a name="input_public_route_tables_name"></a> [public\_route\_tables\_name](#input\_public\_route\_tables\_name) | Set name for public route tables | `string` | `""` | no |
| <a name="input_public_route_tables_propagating_vgws"></a> [public\_route\_tables\_propagating\_vgws](#input\_public\_route\_tables\_propagating\_vgws) | A list of VGWs the public route table should propagate. | `any` | `null` | no |
| <a name="input_public_route_tables_route_ipv4"></a> [public\_route\_tables\_route\_ipv4](#input\_public\_route\_tables\_route\_ipv4) | The CIDR block of the route for IPv4. | `list` | `[]` | no |
| <a name="input_public_route_tables_route_ipv6"></a> [public\_route\_tables\_route\_ipv6](#input\_public\_route\_tables\_route\_ipv6) | (Optional) The Ipv6 CIDR block of the route. | `list` | `[]` | no |
| <a name="input_public_route_tables_vpc_id"></a> [public\_route\_tables\_vpc\_id](#input\_public\_route\_tables\_vpc\_id) | The VPC ID. | `string` | `""` | no |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | CIDR list for Public Subnets | `list(string)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | The region where to deploy this code (e.g. eu-center-1) | `string` | `"eu-central-1"` | no |
| <a name="input_single_nat_gw"></a> [single\_nat\_gw](#input\_single\_nat\_gw) | should be true if you want to provision a single shared NAT Gateway across all of your private networks | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tag blocks. | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR for the whole VPC | `string` | n/a | yes |
| <a name="input_vpc_dhcp_name"></a> [vpc\_dhcp\_name](#input\_vpc\_dhcp\_name) | Set name for VPC DHCP | `string` | `""` | no |
| <a name="input_vpc_dhcp_options_association_dhcp_options_id"></a> [vpc\_dhcp\_options\_association\_dhcp\_options\_id](#input\_vpc\_dhcp\_options\_association\_dhcp\_options\_id) | The ID of the DHCP Options Set to associate to the VPC. | `string` | `""` | no |
| <a name="input_vpc_dhcp_options_association_vpc_id"></a> [vpc\_dhcp\_options\_association\_vpc\_id](#input\_vpc\_dhcp\_options\_association\_vpc\_id) | Set VPC\_ID for dhcp options association | `string` | `""` | no |
| <a name="input_vpc_dhcp_options_domain_name"></a> [vpc\_dhcp\_options\_domain\_name](#input\_vpc\_dhcp\_options\_domain\_name) | (Optional) the suffix domain name to use by default when resolving non Fully Qualified Domain Names. In other words, this is what ends up being the search value in the /etc/resolv.conf file. | `string` | `""` | no |
| <a name="input_vpc_dhcp_options_domain_name_servers"></a> [vpc\_dhcp\_options\_domain\_name\_servers](#input\_vpc\_dhcp\_options\_domain\_name\_servers) | (Optional) List of name servers to configure in /etc/resolv.conf. If you want to use the default AWS nameservers you should set this to AmazonProvidedDNS. | `list(string)` | <pre>[<br>  "AmazonProvidedDNS"<br>]</pre> | no |
| <a name="input_vpc_dhcp_options_netbios_name_servers"></a> [vpc\_dhcp\_options\_netbios\_name\_servers](#input\_vpc\_dhcp\_options\_netbios\_name\_servers) | (Optional) List of NETBIOS name servers. | `list(string)` | `[]` | no |
| <a name="input_vpc_dhcp_options_netbios_node_type"></a> [vpc\_dhcp\_options\_netbios\_node\_type](#input\_vpc\_dhcp\_options\_netbios\_node\_type) | (Optional) The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network. For more information about these node types, see RFC 2132. | `string` | `""` | no |
| <a name="input_vpc_dhcp_options_ntp_servers"></a> [vpc\_dhcp\_options\_ntp\_servers](#input\_vpc\_dhcp\_options\_ntp\_servers) | (Optional) List of NTP servers to configure. | `list(string)` | `[]` | no |
| <a name="input_vpc_enable_classiclink_dns_support"></a> [vpc\_enable\_classiclink\_dns\_support](#input\_vpc\_enable\_classiclink\_dns\_support) | (Optional) A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azs"></a> [azs](#output\_azs) | A list of availability zones specified as argument to this module |
| <a name="output_database_group_name"></a> [database\_group\_name](#output\_database\_group\_name) | n/a |
| <a name="output_igw_arn"></a> [igw\_arn](#output\_igw\_arn) | The ARN of the Internet Gateway |
| <a name="output_igw_id"></a> [igw\_id](#output\_igw\_id) | The ID of the Internet Gateway |
| <a name="output_instance_tenancy"></a> [instance\_tenancy](#output\_instance\_tenancy) | Tenancy of instances spin up within VPC |
| <a name="output_nat_gw_ids"></a> [nat\_gw\_ids](#output\_nat\_gw\_ids) | List of NAT Gateway IDs |
| <a name="output_nat_ids"></a> [nat\_ids](#output\_nat\_ids) | List of allocation ID of Elastic IPs created for AWS NAT Gateway |
| <a name="output_private_nat_gateway_route_ids"></a> [private\_nat\_gateway\_route\_ids](#output\_private\_nat\_gateway\_route\_ids) | List of IDs of the private nat gateway route |
| <a name="output_private_route_table_association_ids"></a> [private\_route\_table\_association\_ids](#output\_private\_route\_table\_association\_ids) | List of IDs of the private route table association |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | List of IDs of private route tables |
| <a name="output_private_subnet_arns"></a> [private\_subnet\_arns](#output\_private\_subnet\_arns) | List of ARNs of private subnets |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of IDs of private subnets |
| <a name="output_private_subnets_cidr_blocks"></a> [private\_subnets\_cidr\_blocks](#output\_private\_subnets\_cidr\_blocks) | List of cidr\_blocks of private subnets |
| <a name="output_public_internet_gateway_route_id"></a> [public\_internet\_gateway\_route\_id](#output\_public\_internet\_gateway\_route\_id) | ID of the internet gateway route |
| <a name="output_public_route_table_association_ids"></a> [public\_route\_table\_association\_ids](#output\_public\_route\_table\_association\_ids) | List of IDs of the public route table association |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | List of IDs of public route tables |
| <a name="output_public_subnet_arns"></a> [public\_subnet\_arns](#output\_public\_subnet\_arns) | List of ARNs of public subnets |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of IDs of public subnets |
| <a name="output_public_subnets_cidr_blocks"></a> [public\_subnets\_cidr\_blocks](#output\_public\_subnets\_cidr\_blocks) | List of cidr\_blocks of public subnets |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | The ARN of the VPC |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_enable_dns_hostnames"></a> [vpc\_enable\_dns\_hostnames](#output\_vpc\_enable\_dns\_hostnames) | Whether or not the VPC has DNS hostname support |
| <a name="output_vpc_enable_dns_support"></a> [vpc\_enable\_dns\_support](#output\_vpc\_enable\_dns\_support) | Whether or not the VPC has DNS support |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vpc_main_route_table_id"></a> [vpc\_main\_route\_table\_id](#output\_vpc\_main\_route\_table\_id) | The ID of the main route table associated with this VPC |
| <a name="output_vpc_owner_id"></a> [vpc\_owner\_id](#output\_vpc\_owner\_id) | The ID of the AWS account that owns the VPC |
