# NOTE: Uncomment and update this file when you have a real domain registered in Route53.

# data "aws_route53_zone" "main" {
#   name         = var.domain_name
#   private_zone = false
# }

# # A Record pointing to CloudFront
# resource "aws_route53_record" "frontend_alias" {
#   zone_id = data.aws_route53_zone.main.zone_id
#   name    = var.domain_name
#   type    = "A"

#   alias {
#     name                   = aws_cloudfront_distribution.frontend_distribution.domain_name
#     zone_id                = aws_cloudfront_distribution.frontend_distribution.hosted_zone_id
#     evaluate_target_health = false
#   }
# }

# # ACM Certificate for CloudFront (must be us-east-1)
# provider "aws" {
#   alias  = "useast1"
#   region = "us-east-1"
# }

# resource "aws_acm_certificate" "cert" {
#   provider          = aws.useast1
#   domain_name       = var.domain_name
#   validation_method = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }
