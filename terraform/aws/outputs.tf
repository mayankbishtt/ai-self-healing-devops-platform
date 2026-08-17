output "s3_bucket_name" {
  description = "Name of the Terraform-managed S3 bucket"
  value       = aws_s3_bucket.devops_artifacts.bucket
}

output "s3_bucket_arn" {
  description = "ARN of the Terraform-managed S3 bucket"
  value       = aws_s3_bucket.devops_artifacts.arn
}