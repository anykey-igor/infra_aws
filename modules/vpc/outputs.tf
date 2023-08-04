output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.cloud_vpc.id, "")
}
output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = try(aws_vpc.cloud_vpc.arn, "")
}
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = try(aws_vpc.cloud_vpc.cidr_block, "")
}
output "instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  value       = try(aws_vpc.cloud_vpc.instance_tenancy, "")
}
output "vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = try(aws_vpc.cloud_vpc.enable_dns_support, "")
}
output "vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = try(aws_vpc.cloud_vpc.enable_dns_hostnames, "")
}
output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = try(aws_vpc.cloud_vpc.main_route_table_id, "")
}
output "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC"
  value       = try(aws_vpc.cloud_vpc.owner_id, "")
}
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public_subnets[*].id
}
output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public_subnets[*].arn
}
output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = compact(aws_subnet.public_subnets[*].cidr_block)
}
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private_subnets[*].id
}
output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = aws_subnet.private_subnets[*].arn
}
output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = compact(aws_subnet.private_subnets[*].cidr_block)
}
output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = aws_route_table.public_route_tables[*].id
}
output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = aws_route_table.private_route_tables[*].id
}
output "public_internet_gateway_route_id" {
  description = "ID of the internet gateway route"
  value       = try(aws_route.public_internet_gateway[0].id, "")
}
output "private_nat_gateway_route_ids" {
  description = "List of IDs of the private nat gateway route"
  value       = aws_route.private_nat_gateway[*].id
}
output "private_route_table_association_ids" {
  description = "List of IDs of the private route table association"
  value       = aws_route_table_association.private_route_table_associations[*].id
}
output "public_route_table_association_ids" {
  description = "List of IDs of the public route table association"
  value       = aws_route_table_association.public_route_table_associations[*].id
}
output "nat_ids" {
  description = "List of allocation ID of Elastic IPs created for AWS NAT Gateway"
  value       = aws_eip.nat_eip[*].id
}
output "nat_gw_ids" {
  description = "List of NAT Gateway IDs"
  value       = aws_nat_gateway.nat_gw[*].id
}
output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = try(aws_internet_gateway.internet_gateway[0].id, "")
}
output "igw_arn" {
  description = "The ARN of the Internet Gateway"
  value       = try(aws_internet_gateway.internet_gateway[0].arn, "")
}
output "azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = var.availability_zones
}
output "database_group_name" {
  value = aws_db_subnet_group.database_subnet_group_name.name
}