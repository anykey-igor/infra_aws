locals {
  create        = var.enable_rds
  is_serverless = var.engine_mode == "serverless"
}

resource "aws_rds_cluster" "default" {
  count                   = local.create ? 1 : 0
  cluster_identifier      = "${lower(var.name)}-aurora-cluster-${lower(var.orchestration)}-${lower(var.environment)}"
  db_subnet_group_name    = var.db_subnet_group_name
  engine                  = var.engine
  engine_version          = var.engine_version
  engine_mode             = var.engine_mode
  database_name           = var.database_name
  master_username         = var.mysql_user
  master_password         = var.mysql_pass
  apply_immediately       = var.apply_immediately
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = "07:00-09:00"
  vpc_security_group_ids  = var.db_sg
  skip_final_snapshot     = var.skip_final_snapshot
  source_region           = var.source_region
  storage_encrypted       = var.storage_encrypted
  storage_type            = var.storage_type
  port                    = var.port
  #availability_zones = var.availability_zones

  dynamic "serverlessv2_scaling_configuration" {
    for_each = length(var.serverlessv2_scaling_configuration) > 0 && var.engine_mode == "provisioned" ? [var.serverlessv2_scaling_configuration] : []
    content {
      max_capacity = serverlessv2_scaling_configuration.value.max_capacity
      min_capacity = serverlessv2_scaling_configuration.value.min_capacity
    }
  }
  lifecycle {
    ignore_changes = [
      replication_source_identifier,
      global_cluster_identifier,
      snapshot_identifier
    ]
  }
  deletion_protection = var.deletion_protection
}

resource "aws_rds_cluster_instance" "database" {
  for_each             = { for k, v in var.instances : k => v if local.create && !local.is_serverless }
  apply_immediately    = try(each.value.apply_immediately, var.apply_immediately)
  availability_zone    = try(each.value.availability_zone, null)
  cluster_identifier   = aws_rds_cluster.default[0].id
  publicly_accessible  = try(each.value.publicly_accessible, var.publicly_accessible)
  instance_class       = try(each.value.instance_class, var.instance_class)
  engine               = var.engine
  engine_version       = var.engine_version
  db_subnet_group_name = var.db_subnet_group_name
}