#---------------------------------------------------
# ECR repo
#---------------------------------------------------

output "aws_ecr_repository_name" {
  description = "The name of the repository."
  value       = element(aws_ecr_repository.ecr_repo.*.name, 0)
}
output "aws_ecr_repository_registry_id" {
  description = "The registry ID where the repository was created."
  value       = element(aws_ecr_repository.ecr_repo.*.registry_id, 0)
}
output "aws_ecr_repository_arn" {
  description = "Full ARN of the repository."
  value       = element(aws_ecr_repository.ecr_repo.*.arn, 0)
}
output "aws_ecr_repository_url" {
  description = "The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName"
  value       = element(aws_ecr_repository.ecr_repo.*.repository_url, 0)
}

