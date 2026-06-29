output "alb_dns_name" {
  description = "The DNS name of the ALB (Backend API)"
  value       = aws_lb.main.dns_name
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution (Frontend)"
  value       = aws_cloudfront_distribution.frontend_distribution.domain_name
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = aws_ecr_repository.backend_repo.repository_url
}

output "s3_frontend_bucket" {
  description = "The name of the S3 bucket for Frontend"
  value       = aws_s3_bucket.frontend_bucket.id
}
