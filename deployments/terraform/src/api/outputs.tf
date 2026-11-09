# Main outputs
output "api_name" {
  value       = var.project_name
  description = "API project name"
}

output "environment" {
  value       = var.environment
  description = "Environment"
}

output "aws_region" {
  value       = var.aws_region
  description = "AWS region"
}
