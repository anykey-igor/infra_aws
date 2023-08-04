resource "aws_vpc_endpoint" "ecr-dkr-endpoint" {
  vpc_id              = var.vpc_id #aws_vpc.main.id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = var.sg_ecs_task_id #[aws_security_group.ecs_task.id]
  subnet_ids          = var.private_subnets_id #aws_subnet.private_subnet.*.id
}

resource "aws_vpc_endpoint" "ecr-api-endpoint" {
  vpc_id              = var.vpc_id #aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = var.sg_ecs_task_id #[aws_security_group.ecs_task.id]
  subnet_ids          = var.private_subnets_id #aws_subnet.private_subnet.*.id
}