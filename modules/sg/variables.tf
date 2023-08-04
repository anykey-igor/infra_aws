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
variable "vpc_id" {
  description = "vpc_id"
}

variable "private_subnet_cidr" {
  description = "List of private subnet cidr block"
}
variable "port" {
  description = "The port on which the DB accepts connections"
  #type        = string
  default     = null
}