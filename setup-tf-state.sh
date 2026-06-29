#!/bin/bash
# Script tạo S3 Bucket và DynamoDB cho Terraform State

REGION="ap-southeast-1"
BUCKET_NAME="pbl3-terraform-state-bucket-unique-123" # Trùng với provider.tf
DYNAMODB_TABLE="terraform-up-and-running-locks"

echo "Creating S3 bucket: $BUCKET_NAME in $REGION..."
aws s3api create-bucket \
    --bucket $BUCKET_NAME \
    --region $REGION \
    --create-bucket-configuration LocationConstraint=$REGION

echo "Enabling versioning on S3 bucket..."
aws s3api put-bucket-versioning \
    --bucket $BUCKET_NAME \
    --versioning-configuration Status=Enabled

echo "Creating DynamoDB table: $DYNAMODB_TABLE..."
aws dynamodb create-table \
    --table-name $DYNAMODB_TABLE \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region $REGION

echo "✅ State resources created successfully!"
echo "Now you can run: cd infrastructure && terraform init"
