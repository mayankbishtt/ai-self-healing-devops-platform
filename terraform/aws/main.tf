resource "aws_s3_bucket" "devops_artifacts" {
  bucket_prefix = "ai-devops-artifacts-"

  tags = {
    Name        = "ai-devops-artifacts"
    Environment = "learning"
    ManagedBy   = "Terraform"
    Project     = "AI-Self-Healing-DevOps"
  }
}

resource "aws_s3_bucket_public_access_block" "devops_artifacts" {
  bucket = aws_s3_bucket.devops_artifacts.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_kms_key" "devops_artifacts" {
  description             = "KMS key for AI DevOps artifact bucket"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name        = "ai-devops-artifacts-key"
    Environment = "learning"
    ManagedBy   = "Terraform"
  }
}

resource "aws_kms_alias" "devops_artifacts" {
  name          = "alias/ai-devops-artifacts"
  target_key_id = aws_kms_key.devops_artifacts.key_id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "devops_artifacts" {
  bucket = aws_s3_bucket.devops_artifacts.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.devops_artifacts.arn
    }
  }
}