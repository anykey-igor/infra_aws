# ---------------------------------------------------------------------------------------------------------------------
# VPC
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_vpc" "cloud_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    {
      Name = "${lower(var.project)}-vpc-${lower(var.environment)}"
    },
    var.tags
  )
}

# ---------------------------------------------------------------------------------------------------------------------
# Subnet
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidr)

  cidr_block              = var.public_subnet_cidr[count.index]
  vpc_id                  = aws_vpc.cloud_vpc.id
  availability_zone       = length(var.availability_zones) > 0 ? var.availability_zones[count.index] : element(lookup(var.availability_zones_list, var.region), count.index)
  map_public_ip_on_launch = true

  lifecycle {
    create_before_destroy = true
    #ignore_changes        = []
  }
  depends_on = [
    aws_vpc.cloud_vpc
  ]
  tags = merge(
    {
      Name = "${lower(var.project)}-public_subnet-${lower(var.environment)}-${var.orchestration}-${element(lookup(var.availability_zones_list, var.region), count.index)}"
    },
    var.tags
  )
}

# ---------------------------------------------------------------------------------------------------------------------
# Add AWS Subnet to VPC - private
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidr)

  cidr_block              = var.private_subnet_cidr[count.index]
  vpc_id                  = aws_vpc.cloud_vpc.id
  map_public_ip_on_launch = false
  availability_zone       = length(var.availability_zones) > 0 ? var.availability_zones[count.index] : element(lookup(var.availability_zones_list, var.region), count.index)

  tags = merge(
    {
      Name = "${lower(var.project)}-private_subnet-${lower(var.environment)}--${var.orchestration}-${element(lookup(var.availability_zones_list, var.region), count.index)}"
    },
    var.tags
  )
  lifecycle {
    create_before_destroy = true
    #ignore_changes        = []
  }
  depends_on = [
    aws_vpc.cloud_vpc
  ]
}

#----------------------------------------------------------------------------------------------------------------------
# Create public route table
#----------------------------------------------------------------------------------------------------------------------
resource "aws_route_table" "public_route_tables" {
  count  = length(var.public_subnet_cidr) > 0 ? 1 : 0
  vpc_id = aws_vpc.cloud_vpc.id

  dynamic "route" {
    iterator = route_ipv4
    for_each = var.public_route_tables_route_ipv4

    content {
      cidr_block = lookup(route_ipv4.value, "cidr_block", "0.0.0.0/0")
      gateway_id = lookup(route_ipv4.value, "gateway_id", null)

      egress_only_gateway_id    = lookup(route_ipv4.value, "egress_only_gateway_id", null)
      nat_gateway_id            = lookup(route_ipv4.value, "nat_gateway_id", null)
      local_gateway_id          = lookup(route_ipv4.value, "local_gateway_id", null)
      network_interface_id      = lookup(route_ipv4.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route_ipv4.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route_ipv4.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route_ipv4.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    {
      Name = "${lower(var.project)}-public-route-tables-${lower(var.environment)}"
    },
    var.tags
  )
  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }
  depends_on = [
    aws_vpc.cloud_vpc,
    aws_subnet.public_subnets
  ]
}

resource "aws_internet_gateway" "internet_gateway" {
  count  = var.enable_internet_gw && length(var.public_subnet_cidr) > 0 ? 1 : 0
  vpc_id = var.internet_gw_vpc_id != "" ? var.internet_gw_vpc_id : aws_vpc.cloud_vpc.id

  tags = merge(
    {
      Name = var.internet_gw_name != "" ? lower(var.internet_gw_name) : "${lower(var.project)}-internet-gw-${lower(var.environment)}"
    },
    var.tags
  )
  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }
  depends_on = [
    aws_vpc.cloud_vpc
  ]
}

#----------------------------------------------------------------------------------------------------------------------
# Create private route table and the route to the internet
#----------------------------------------------------------------------------------------------------------------------
resource "aws_route_table" "private_route_tables" {
  count  = var.enable_nat_gw && length(var.private_subnet_cidr) > 0 ? (var.single_nat_gw ? 1 : (length(var.private_subnet_cidr) > 0 ? length(var.private_subnet_cidr) : length(var.private_subnet_cidr))) : 1
  vpc_id = aws_vpc.cloud_vpc.id

  dynamic "route" {
    iterator = route_ipv4
    for_each = var.private_route_tables_route_ipv4

    content {
      cidr_block = lookup(route_ipv4.value, "cidr_block", "0.0.0.0/0")
      gateway_id = lookup(route_ipv4.value, "gateway_id", null)

      egress_only_gateway_id    = lookup(route_ipv4.value, "egress_only_gateway_id", null)
      nat_gateway_id            = lookup(route_ipv4.value, "nat_gateway_id", null)
      local_gateway_id          = lookup(route_ipv4.value, "local_gateway_id", null)
      network_interface_id      = lookup(route_ipv4.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route_ipv4.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route_ipv4.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route_ipv4.value, "vpc_peering_connection_id", null)
    }
  }
  tags = merge(
    {
      Name = var.private_route_tables_name != "" ? lower(var.private_route_tables_name) : "${lower(var.project)}-private-route-tables-${lower(var.environment)}"
    },
    var.tags
  )
  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }
  depends_on = [
    aws_vpc.cloud_vpc
  ]
}

#---------------------------------------------------
# AWS Route Table Associations
#---------------------------------------------------
# public
resource "aws_route_table_association" "public_route_table_associations" {
  count = length(var.public_subnet_cidr)

  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.public_route_tables.*.id, count.index)

  depends_on = [
    aws_route_table.public_route_tables,
    aws_subnet.public_subnets
  ]
}

# private
resource "aws_route_table_association" "private_route_table_associations" {
  count = length(var.private_subnet_cidr)

  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = element(aws_route_table.private_route_tables.*.id, count.index)

  depends_on = [
    aws_route_table.private_route_tables,
    aws_subnet.private_subnets
  ]
}

#----------------------------------------------------------------------------------------------------------------------
# Add AWS Route
#----------------------------------------------------------------------------------------------------------------------
# Create route table for public internet gateway
#----------------------------------------------------------------------------------------------------------------------
resource "aws_route" "public_internet_gateway" {
  count = var.enable_internet_gw && length(var.public_subnet_cidr) > 0 ? 1 : 0

  route_table_id         = element(aws_route_table.public_route_tables.*.id, 0)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = element(aws_internet_gateway.internet_gateway.*.id, 0)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }
  depends_on = [
    aws_route_table.public_route_tables,
    aws_internet_gateway.internet_gateway
  ]
}

#---------------------------------------------------------------------------------------------------------------------
# Add AWS NAT Gateway
#---------------------------------------------------------------------------------------------------------------------
resource "aws_nat_gateway" "nat_gw" {
  count = var.enable_nat_gw ? (var.single_nat_gw ? 1 : (length(var.private_subnet_cidr) > 0 ? length(var.private_subnet_cidr) : length(var.private_subnet_cidr))) : 0

  subnet_id         = element(aws_subnet.public_subnets.*.id, (var.single_nat_gw ? 0 : count.index))
  allocation_id     = element(aws_eip.nat_eip.*.id, (var.single_nat_gw ? 0 : count.index))
  connectivity_type = var.nat_gw_connectivity_type # default in AWS "public"

  tags = merge(
    {
      Name = var.nat_gw_name != "" ? lower(var.nat_gw_name) : "${lower(var.project)}-nat-gw-${lower(var.environment)}"
    },
    var.tags
  )
  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }
  depends_on = [
    aws_eip.nat_eip,
    aws_subnet.public_subnets
  ]
}

#---------------------------------------------------------------------------------------------------------------------
# AWS EIP
#---------------------------------------------------------------------------------------------------------------------
resource "aws_eip" "nat_eip" {
  count = var.enable_nat_gw ? (var.single_nat_gw ? 1 : (length(var.private_subnet_cidr) > 0 ? length(var.private_subnet_cidr) : length(var.private_subnet_cidr))) : 0

  vpc               = var.nat_eip_vpc
  instance          = var.nat_eip_instance
  network_interface = var.nat_eip_network_interface

  tags = merge(
    {
      Name = var.nat_eip_name != "" ? lower(var.nat_eip_name) : "${lower(var.project)}-nat-eip-${count.index + 1}-${lower(var.environment)}"
    },
    var.tags
  )
  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }
  depends_on = []
}

#----------------------------------------------------------------------------------------------------------------------#
# Create route table for private NAT gateway
#----------------------------------------------------------------------------------------------------------------------
resource "aws_route" "private_nat_gateway" {
  count = var.enable_nat_gw && length(var.private_subnet_cidr) > 0 ? (var.single_nat_gw ? 1 : (length(var.private_subnet_cidr) > 0 ? length(var.private_subnet_cidr) : length(var.private_subnet_cidr))) : 0

  route_table_id         = element(aws_route_table.private_route_tables.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat_gw.*.id, count.index)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }
  depends_on = [
    aws_route_table.private_route_tables,
    aws_nat_gateway.nat_gw
  ]
}

resource "aws_db_subnet_group" "database_subnet_group_name" {
  name        = "${lower(var.project)}-db-group-name-${lower(var.orchestration)}-${lower(var.environment)}"
  description = "${lower(var.project)}-db-group-name-${lower(var.orchestration)}-${lower(var.environment)}"
  subnet_ids  = aws_subnet.private_subnets.*.id
}