#---------------------------------------------------------------------------------------------------------------------
# VPC output
#---------------------------------------------------------------------------------------------------------------------
output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(module.vpc.vpc_id, "")
}
output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = try(module.vpc.vpc_arn, "")
}
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = try(module.vpc.vpc_cidr_block, "")
}
output "instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  value       = try(module.vpc.instance_tenancy, "")
}
output "vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = try(module.vpc.vpc_enable_dns_support, "")
}
output "vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = try(module.vpc.vpc_enable_dns_hostnames, "")
}
output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = try(module.vpc.vpc_main_route_table_id, "")
}
output "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC"
  value       = try(module.vpc.vpc_owner_id, "")
}
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}
output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = module.vpc.private_subnet_arns
}
output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = compact(module.vpc.public_subnets_cidr_blocks)
}
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}
output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = module.vpc.private_subnet_arns
}
output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = compact(module.vpc.private_subnets_cidr_blocks)
}
output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = module.vpc.public_route_table_ids
}
output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = module.vpc.private_route_table_ids
}
output "public_internet_gateway_route_id" {
  description = "ID of the internet gateway route"
  value       = try(module.vpc.public_internet_gateway_route_id, "")
}
output "private_nat_gateway_route_ids" {
  description = "List of IDs of the private nat gateway route"
  value       = try(module.vpc.private_nat_gateway_route_ids, "")
}
output "private_route_table_association_ids" {
  description = "List of IDs of the private route table association"
  value       = module.vpc.private_route_table_association_ids
}
output "public_route_table_association_ids" {
  description = "List of IDs of the public route table association"
  value       = module.vpc.public_route_table_association_ids
}
output "nat_ids" {
  description = "List of allocation ID of Elastic IPs created for AWS NAT Gateway"
  value       = try(module.vpc.nat_ids, "")
}
output "nat_gw_ids" {
  description = "List of NAT Gateway IDs"
  value       = try(module.vpc.nat_gw_ids, "")
}
output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = try(module.vpc.igw_id, "")
}
output "igw_arn" {
  description = "The ARN of the Internet Gateway"
  value       = try(module.vpc.igw_arn, "")
}

#output "azs" {
#  description = "A list of availability zones specified as argument to this module"
#  value       = var.availability_zones
#}

#---------------------------------------------------------------------------------------------------------------------
# ECR output
#---------------------------------------------------------------------------------------------------------------------
output "aws_ecr_backend_repository_name" {
  description = "The name of the repository."
  value = module.ecr_backend.aws_ecr_repository_name
}
output "aws_ecr_backend_repository_arn" {
  description = "Full ARN of the repository."
  value = module.ecr_backend.aws_ecr_repository_arn
}
output "aws_ecr_backend_repository_url" {
  description = "The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName"
  value = module.ecr_backend.aws_ecr_repository_url
}
output "aws_ecr_backend_repository_registry_id" {
  description = "The registry ID where the repository was created."
  value = module.ecr_backend.aws_ecr_repository_registry_id
}

output "aws_ecr_frontend_repository_name" {
  description = "The name of the repository."
  value = module.ecr_backend.aws_ecr_repository_name
}
output "aws_ecr_frontend_repository_arn" {
  description = "Full ARN of the repository."
  value = module.ecr_backend.aws_ecr_repository_arn
}
output "aws_ecr_frontend_repository_url" {
  description = "The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName"
  value = module.ecr_backend.aws_ecr_repository_url
}
output "aws_ecr_frontend_repository_registry_id" {
  description = "The registry ID where the repository was created."
  value = module.ecr_backend.aws_ecr_repository_registry_id
}

output "database_group_name" {
  value = module.vpc.database_group_name
}

#output "aws_alb_target_group_arn" {
#  value = module.alb.aws_alb_target_group_arn
#}
#---------------------------------------------------------------------------------------------------------------------#
# Security Group
#---------------------------------------------------------------------------------------------------------------------#
output "sg_alb_http_pl_easteu_id" {
  value = module.sg_backend.sg_alb_http_pl_easteu_id
}
output "sg_alb_http_pl_asia_id" {
  value = module.sg_backend.sg_alb_http_pl_asia_id
}
output "sg_alb_https_pl_easteu_id" {
  value = module.sg_backend.sg_alb_https_pl_easteu_id
}
output "sg_alb_https_pl_asia_id" {
  value = module.sg_backend.sg_alb_https_pl_asia_id
}
output "sg_ecs_service" {
  value = module.sg_backend.sg_ecs_service
}
output "sg_database_ecs_id" {
  value = module.sg_backend.sg_database_ecs_id
}

#output "alb_dns_name" {
#  value = module.alb.alb_dns_name
#}
#output "alb_zone_id" {
#  value = module.alb.alb_zone_id
#}

#output "alb_sg_http_1" {
#  value = module.alb.alb_security_group_http_1
#}
#output "alb_sg_http_2" {
#  value = module.alb.alb_security_group_http_2
#}
#output "alb_sg_https_1" {
#  value = module.alb.alb_security_group_https_1
#}
#output "alb_sg_https_2" {
#  value = module.alb.alb_security_group_https_2
#}
#output "ecs_service_sg" {
#  value = module.ecs.ecs_service_sg
#}
#---------------------------------------------------------------------------------------------------------------------#
# Route 53
#---------------------------------------------------------------------------------------------------------------------#
output "domain_summary" {
  value = module.r53.domain_summary
}
output "domain_id" {
  value = module.r53.domain_id
}
output "domain_arn" {
  value = module.r53.domain_arn
}
output "domain_zone_id" {
  value = module.r53.domain_zone_id
}
output "domain_name" {
  value = module.r53.domain_name
}


#---------------------------------------------------------------------------------------------------------------------#
# ACM
#---------------------------------------------------------------------------------------------------------------------#
output "acm_certificate_arn_frontend" {
  description = "The ARN of the certificate"
  value       = module.acm_frontend.acm_certificate_arn
}

output "acm_certificate_domain_validation_options_frontend" {
  description = "A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used."
  value       = module.acm_frontend.acm_certificate_domain_validation_options
}

output "acm_certificate_status_frontend" {
  description = "Status of the certificate."
  value       = module.acm_frontend.acm_certificate_status
}

output "acm_certificate_arn_backend" {
  description = "The ARN of the certificate"
  value       = module.acm_backend.acm_certificate_arn
}

output "acm_certificate_domain_validation_options_backend" {
  description = "A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used."
  value       = module.acm_backend.acm_certificate_domain_validation_options
}

output "acm_certificate_status_backend" {
  description = "Status of the certificate."
  value       = module.acm_backend.acm_certificate_status
}

output "dist_arn" {
  value = module.frontend.dist_arn
}
output "oai_arn" {
  value = module.frontend.oai_arn
}

output "cloudfront_dist_domain_name" {
  value = module.frontend.cloudfront_dist_domain_name
}
output "cloudfront_dist_hosted_zone_id" {
  value = module.frontend.cloudfront_dist_zone_id
}