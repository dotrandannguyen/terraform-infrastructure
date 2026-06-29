terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Lưu ý: Cần tạo S3 bucket và DynamoDB table trước khi bật tính năng này
  backend "s3" {
    bucket         = "pbl3-terraform-state-bucket-unique-123" # Thay bằng tên bucket của bạn
    key            = "global/s3/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}
