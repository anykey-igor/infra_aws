module "aurora_mysql_v2" {
  source = "modulesds"

  enable_rds           = true
  environment          = var.environment
  name                 = var.project
  engine               = "aurora-mysql"
  engine_mode          = "provisioned"
  engine_version       = "8.0.mysql_aurora.3.02.3"
  database_name        = var.env_dbname #need add aws_ssm_parameter module
  db_subnet_group_name = module.vpc.database_group_name
  availability_zones   = ["eu-central-1a", "eu-central-1b"]
  port                 = 3306
  vpc_id               = module.vpc.vpc_id
  cidr_blocks          = module.vpc.private_subnets_cidr_blocks
  mysql_user           = var.env_user #need add aws_secretsmanager_secret module
  mysql_pass           = var.env_pass #need add aws_secretsmanager_secret module
  storage_encrypted    = false
  #monitoring_interval = 60
  publicly_accessible = true
  apply_immediately   = true
  skip_final_snapshot = true
  source_region       = var.region

  serverlessv2_scaling_configuration = {
    min_capacity = 0.5
    max_capacity = 1
  }

  instance_class = "db.serverless"
  instances = {
    one = {}
    #two = {}
  }
  db_sg      = [module.sg_backend.sg_database_ecs_id]
  depends_on = [module.vpc]
}
