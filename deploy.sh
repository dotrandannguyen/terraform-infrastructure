#!/bin/bash
# Script hỗ trợ các thao tác deploy nhanh nếu không dùng CI/CD

echo "Usage: ./deploy.sh [target]"
echo "Targets:"
echo "  infra   - Triển khai Terraform (cd infrastructure && terraform apply)"
echo "  backend - Build & Push Docker image cho Backend"
echo "  frontend- Build & Sync React app lên S3"

# Chi tiết script sẽ được bổ sung ở các Phase sau.
