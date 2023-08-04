#-----------------------------------------------------------
# Variable: global or default
#-----------------------------------------------------------
variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "eu-central-1"
}
variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  type        = string
}
variable "public_subnet_cidr" {
  description = "CIDR list for Public Subnets"
  type        = list(string)
  default     = []
}
variable "private_subnet_cidr" {
  description = "CIDR list for Private Subnets"
  type        = list(string)
  default     = []
}

#-----------------------------------------------------------
# Variable: TAGS
#-----------------------------------------------------------
variable "project" {
  description = "Name of Project"
  default     = "test"
}
variable "environment" {
  description = "Environment for service"
  default     = "test"
}
variable "orchestration" {
  description = "Type of Orchestration"
  default     = "tf"
}
variable "createdby" {
  description = "Created by"
  default     = "Anikeiev Ihor"
}
variable "team" {
  description = "Team"
  default     = "number_of_team"
}
variable "contact_email" {
  description = "Contact Email"
  default     = "contact_email"
}
variable "enable_ecr_repo_policy" {
  description = "Enable ecr repo policy usage"
  default     = false
}
variable "ecr_repo_policy_template" {
  description = "Json file with policy"
  default     = ""
}
variable "enable_ecr_lifecycle_policy" {
  description = "Enable ecr lifecycle policy"
  default     = false
}
variable "ecr_lifecycle_policy" {
  description = "Json file with lifecycle policy"
  default     = ""
}
variable "domain_name" {
  description = "Hosted Zone"
  type        = string
}
variable "frontend_url" {
  description = "Front-end URL"
  type        = string
}
variable "backend_url" {
  description = "Back-End URL"
  type        = string
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
variable "env_dbname" {}
variable "env_user" {}
variable "env_pass" {}