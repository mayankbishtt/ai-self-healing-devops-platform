resource "aws_s3_bucket" "devops_artifacts" {
  bucket_prefix = "ai-devops-artifacts-"

  tags = {
    Name        = "ai-devops-artifacts"
    Environment = "learning"
    ManagedBy   = "Terraform"
    Project     = "AI-Self-Healing-DevOps"
  }
}