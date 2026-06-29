variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-southeast-1"
}

variable "project_name" {
  description = "Project name used for tagging and naming resources"
  type        = string
  default     = "pbl3-unified-workspace"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "frontend_bucket_name" {
  description = "Name of the S3 bucket for frontend hosting"
  type        = string
  default     = "pbl3-unified-workspace-frontend-ui"
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "pbl3-backend-repo"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "pbl3-fargate-cluster"
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 3000
}
