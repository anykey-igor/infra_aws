#---------------------------------------------------------------------------------------------------------------------
# General Variables
#---------------------------------------------------------------------------------------------------------------------
variable "project" {
  description = "Name of Project"
  default = "test"
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
variable "domain_name" {
  type = string
  description = "Domain name"
}
variable "certificate_arn" {
  type = string
}
