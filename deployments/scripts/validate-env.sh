#!/bin/bash
set -e

echo "🔍 Validating environment configuration..."

REQUIRED_VARS=(
  "AWS_REGION"
  "AWS_ACCOUNT_ID"
  "EKS_CLUSTER_NAME"
  "ECR_REGISTRY"
)

for var in "${REQUIRED_VARS[@]}"; do
  if [ -z "${!var}" ]; then
    echo "❌ Error: $var is not set"
    exit 1
  fi
  echo "✅ $var is set"
done

# Check AWS CLI
if ! command -v aws &> /dev/null; then
  echo "❌ AWS CLI is not installed"
  exit 1
fi

# Check kubectl
if ! command -v kubectl &> /dev/null; then
  echo "❌ kubectl is not installed"
  exit 1
fi

# Check Helm
if ! command -v helm &> /dev/null; then
  echo "❌ Helm is not installed"
  exit 1
fi

echo "🎉 All validations passed!"
