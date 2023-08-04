terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  #backend "local" {}
  backend "s3" {
    bucket         = "app-team1-s3-rstate-dev-tf"
    key            = "infra/dev/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "app-team1-dynamodb-lock-tf"
    encrypt        = true
  }
}

# Configure the modules Provider
provider "aws" {
  region = "eu-central-1"

  default_tags {
    tags = {
      Project     = var.project
      Team        = var.team
      Environment = var.environment
      CreatedBy   = var.createdby
      Email       = var.contact_email
    }
  }
}