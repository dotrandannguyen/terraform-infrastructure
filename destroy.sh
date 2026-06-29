#!/bin/bash
# Dọn dẹp toàn bộ Infrastructure bằng Terraform
# Cảnh báo: Lệnh này sẽ xóa toàn bộ tài nguyên trên AWS!

echo "WARNING: This will destroy all AWS resources created by Terraform."
read -p "Are you sure you want to proceed? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Emptying S3 bucket to allow destruction..."
    # Lấy tên bucket (cần thay bằng giá trị thực tế nếu output chưa chạy)
    BUCKET_NAME=$(cd infrastructure && terraform output -raw s3_frontend_bucket 2>/dev/null || echo "pbl3-app-frontend-bucket-unique-123")
    aws s3 rm s3://$BUCKET_NAME --recursive

    echo "Emptying ECR repository..."
    # Cách đơn giản nhất để Terraform có thể xóa ECR (đã bật force_delete trong repo là tốt nhất, nhưng đề phòng)
    REPO_NAME="pbl3-app-backend"
    IMAGES=$(aws ecr list-images --repository-name $REPO_NAME --query 'imageIds[*]' --output json 2>/dev/null)
    if [ "$IMAGES" != "null" ]; then
        aws ecr batch-delete-image --repository-name $REPO_NAME --image-ids "$IMAGES" 2>/dev/null
    fi

    echo "Running Terraform Destroy..."
    cd infrastructure
    terraform destroy -auto-approve
    echo "Destroy completed."
fi
