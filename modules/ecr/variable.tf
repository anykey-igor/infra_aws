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

#---------------------------------------------------------------------------------------------------------------------
# Variable for ECR repository
#---------------------------------------------------------------------------------------------------------------------
variable "enable_ecr_repo" {
  description = "Enable ecr repo creating"
  type        = bool
  default     = false
}
variable "ecr_repo_name" {
  description = "(Required) Name of the repository."
  type        = string
  default     = ""
}
variable "image_tag_mutability" {
  description = "(Optional) The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE. Defaults to MUTABLE"
  type = string
  default = "MUTABLE"
}
variable "ecr_repo_encryption_type" {
  description = "(Optional) The encryption type to use for the repository. Valid values are AES256 or KMS. Defaults to AES256"
  type = string
  default = "AES256"
}
variable "ecr_repo_scan_images" {
  description = "(Optional) Configuration block that defines image scanning configuration for the repository. By default, image scanning must be manually triggered. "
  type = bool
  default = false
}
#---------------------------------------------------------------------------------------------------------------------
# ECR repo policy
#---------------------------------------------------------------------------------------------------------------------
variable "enable_ecr_repo_policy" {
  description = "Enable ecr repo policy usage"
  default     = false
}
variable "ecr_policy_repository" {
  description = "(Required) Name of the repository to apply the policy."
  default     = ""
}
variable "ecr_repo_policy_template" {
  description = "Json file with policy"
  default     = ""
}
#---------------------------------------------------------------------------------------------------------------------
# ECR lifecycle policy
#---------------------------------------------------------------------------------------------------------------------
variable "enable_ecr_lifecycle_policy" {
  description = "Enable ecr lifecycle policy"
  default     = false
}
variable "ecr_lifecycle_policy_repository" {
  description = "Set repository for lifecycle policy resource"
  default     = ""
}

variable "ecr_lifecycle_policy" {
  description = "Json file with lifecycle policy"
  default     = ""
}