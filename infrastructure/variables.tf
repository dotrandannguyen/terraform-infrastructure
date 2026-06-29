variable "aws_region" {
  description = "AWS region"
  default     = "ap-southeast-1"
}

variable "project_name" {
  description = "Name of the project"
  default     = "pbl3-app"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  default     = "prod"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "domain_name" {
  description = "Domain name for the application (Route53)"
  default     = "example.com" # Hãy thay bằng tên miền thật
}
