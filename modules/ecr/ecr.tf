#---------------------------------------------------------------------------------------------------------------------
# Create AWS ECR repository
#---------------------------------------------------------------------------------------------------------------------
resource "aws_ecr_repository" "ecr_repo" {
  count                = var.enable_ecr_repo ? 1 : 0
  name                 = "${lower(var.project)}-${var.ecr_repo_name}-ecr-${var.orchestration}-${lower(var.environment)}"
  image_tag_mutability = var.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = var.ecr_repo_scan_images
  }
  encryption_configuration {
    encryption_type = var.ecr_repo_encryption_type
  }
  tags = merge(
    {
      Name = "${lower(var.project)}-backend-ecr-${var.orchestration}-${lower(var.environment)}"
    },
    var.tags
  )
  depends_on = []
}

#---------------------------------------------------------------------------------------------------------------------
# AWS ECR repository policy
#---------------------------------------------------------------------------------------------------------------------
data "template_file" "policy" {
  template = var.ecr_repo_policy_template
}

resource "aws_ecr_repository_policy" "ecr_repository_policy" {
  count = var.enable_ecr_repo_policy ? 1 : 0

  repository = var.ecr_policy_repository != "" && var.enable_ecr_repo ? var.ecr_policy_repository : element(aws_ecr_repository.ecr_repo.*.name, 0)
  policy     = data.template_file.policy.rendered

  depends_on = [
    aws_ecr_repository.ecr_repo,
    data.template_file.policy
  ]
}

#---------------------------------------------------------------------------------------------------------------------
# AWS ECR repository
#---------------------------------------------------------------------------------------------------------------------
data "template_file" "lifecycle_policy" {
  template = var.ecr_lifecycle_policy
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  count = var.enable_ecr_lifecycle_policy ? 1 : 0

  repository = var.ecr_lifecycle_policy_repository != "" && var.enable_ecr_repo ? var.ecr_lifecycle_policy_repository : element(aws_ecr_repository.ecr_repo.*.name, 0)
  policy     = data.template_file.lifecycle_policy.rendered

  depends_on = [
    aws_ecr_repository.ecr_repo,
    data.template_file.lifecycle_policy
  ]
}