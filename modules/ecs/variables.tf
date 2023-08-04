variable "vpc_id" {
  description = "vpc_id"
}
variable "project" {
  description = "Name of Project"
  default     = "test"
}
variable "orchestration" {
  description = "Type of Orchestration"
  default     = "tf"
}
variable "environment" {
  description = "Environment for service"
  type        = string
  default     = "DEMO"
}
variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch."
  type        = map(string)
  default     = {}
}
variable "subnets" {
  description = "List of subnet IDs used by database subnet group created"
  type        = list(string)
  default     = []
}
variable "aws_alb_target_group_arn" {
  description = "aws_alb_target_group_arn"
}
variable "sg_ecs" {
  description = "ECS security groups"
  type        = list(string)
}
variable "max_capacity_service_task" {
  type = number
  default = 1
  description = "Maximum count of service task"
}
variable "min_capacity_service_task" {
  type = number
  default = 1
  description = "Minimum count of service task"
}