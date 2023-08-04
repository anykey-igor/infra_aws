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
variable "vpc_id" {
  description = "vpc_id"
}
variable "certificate_backend" {
  type        = string
  description = "Certificate ARN"
}
variable "alb_sg_list" {
  type        = list(string)
  description = "List of Security groups for ALB"
}