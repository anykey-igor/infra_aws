################################################################################
# DB Subnet Group
################################################################################
variable "cidr_blocks" {
  description = "CIDR block ingress for ingress"
  type        = list(string)
  default     = []
}
variable "mysql_user" {
  description = "User name"
  type        = string
}
variable "mysql_pass" {
  description = "Password to DB"
  type        = string
}
variable "enable_rds" {
  type    = bool
  default = false
}
variable "environment" {
  description = "Environment for service"
  default     = "test"
}
variable "orchestration" {
  description = "Type of Orchestration"
  default     = "tf"
}
variable "instances" {
  description = "Map of cluster instances and any specific/overriding attributes to be created"
  type        = any
  default     = {}
}
variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = ""
}
variable "name" {
  description = "Name used across resources created"
  type        = string
  default     = ""
}
variable "publicly_accessible" {
  description = "Determines whether instances are publicly accessible. Default `false`"
  type        = bool
  default     = null
}
variable "port" {
  description = "The port on which the DB accepts connections"
  #type        = string
  default = null
}
variable "instance_class" {
  description = "Instance type to use at master instance. Note: if `autoscaling_enabled` is `true`, this will be the same instance class used on instances created by autoscaling"
  type        = string
  default     = ""
}
variable "availability_zones" {
  description = "List of EC2 Availability Zones for the DB cluster storage where DB cluster instances can be created. RDS automatically assigns 3 AZs if less than 3 AZs are configured, which will show as a difference requiring resource recreation next Terraform apply"
  type        = list(string)
  default     = null
}
variable "tags" {
  description = "A list of tag blocks."
  type        = map(string)
  default     = {}
}
variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is `false`"
  type        = bool
  default     = null
}
variable "backup_retention_period" {
  description = "The days to retain backups for. Default `7`"
  type        = number
  default     = 7
}
variable "skip_final_snapshot" {
  description = "Determines whether a final snapshot is created before the cluster is deleted. If true is specified, no snapshot is created"
  type        = bool
  default     = false
}
variable "source_region" {
  description = "The source region for an encrypted replica DB cluster"
  type        = string
  default     = null
}
variable "storage_encrypted" {
  description = "Specifies whether the DB cluster is encrypted. The default is `true`"
  type        = bool
  default     = true
}
variable "storage_type" {
  description = "Specifies the storage type to be associated with the DB cluster. (This setting is required to create a Multi-AZ DB cluster). Valid values: `io1`, Default: `io1`"
  type        = string
  default     = null
}
variable "serverlessv2_scaling_configuration" {
  description = "Map of nested attributes with serverless v2 scaling properties. Only valid when `engine_mode` is set to `provisioned`"
  type        = map(string)
  default     = {}
}
variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to `true`. The default is `false`"
  type        = bool
  default     = null
}
variable "engine" {
  description = "The name of the database engine to be used for this DB cluster. Defaults to `aurora`. Valid Values: `aurora`, `aurora-mysql`, `aurora-postgresql`"
  type        = string
  default     = null
}
variable "engine_mode" {
  description = "The database engine mode. Valid values: `global`, `multimaster`, `parallelquery`, `provisioned`, `serverless`. Defaults to: `provisioned`"
  type        = string
  default     = "provisioned"
}
variable "engine_version" {
  description = "The database engine version. Updating this argument results in an outage"
  type        = string
  default     = null
}
variable "database_name" {
  description = "Name for an automatically created database on cluster creation"
  type        = string
  default     = null
}
variable "create_db_subnet_group" {
  description = "Determines whether to create the database subnet group or use existing"
  type        = bool
  default     = false
}
variable "db_subnet_group_name" {
  description = "The name of the subnet group name (existing or created)"
  type        = string
  default     = ""
}
variable "subnets" {
  description = "List of subnet IDs used by database subnet group created"
  type        = list(string)
  default     = []
}
variable "db_sg" {
  type        = list(string)
  description = "List of Security Groups for DataBase"
}