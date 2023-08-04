#---------------------------------------------------
# Create S3 bucket
#---------------------------------------------------

# The name of bucket  must be unique throughout the internet.
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${lower(var.name)}-s3-rstate-${var.environment}-${var.orchestration}"

  force_destroy = var.force_destroy

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name          = "${lower(var.name)}-s3-rstate-${var.environment}-${var.orchestration}"
    Orchestration = "${var.orchestration}"
    #Environment   = "${var.environment}"
    CreatedBy = "${var.createdby}"
  }
}

# Enable version control for modules S3 bucket
resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable encryption on side Amazon
resource "aws_s3_bucket_server_side_encryption_configuration" "encription_on_s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "infra_terraform_locks" {
  name         = "${var.name}-dynamodb-lock-${var.orchestration}"
  billing_mode = var.dynamodb_t_billing_mode
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name          = "${var.name}-dynamodb-lock-${var.orchestration}"
    Orchestration = "${var.orchestration}"
    #Environment   = "${var.environment}"
    CreatedBy = "${var.createdby}"
  }
}
#----------------------------------------------------------------#