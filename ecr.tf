module "ecr_backend" {
  source                      = "modulescr"
  enable_ecr_repo             = true
  ecr_repo_name               = "backend"
  project                     = var.project
  environment                 = var.environment
  image_tag_mutability        = "MUTABLE"
  enable_ecr_repo_policy      = true
  ecr_repo_policy_template    = file("ecr_policy/policy.json")
  enable_ecr_lifecycle_policy = true
  ecr_lifecycle_policy        = file("ecr_policy/lifecycle_policy.json")
}

module "ecr_frontend" {
  source                      = "modulescr"
  enable_ecr_repo             = true
  ecr_repo_name               = "frontend"
  project                     = var.project
  environment                 = var.environment
  image_tag_mutability        = "MUTABLE"
  enable_ecr_repo_policy      = true
  ecr_repo_policy_template    = file("ecr_policy/policy.json")
  enable_ecr_lifecycle_policy = true
  ecr_lifecycle_policy        = file("ecr_policy/lifecycle_policy.json")
}