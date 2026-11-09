#!/bin/bash
set -e

echo "🚀 Deploying Sample Project API..."

ENVIRONMENT=${1:-staging}
REGION=${AWS_REGION:-us-east-1}
NAMESPACE=${ENVIRONMENT}

echo "📦 Environment: $ENVIRONMENT"
echo "🌍 Region: $REGION"

# Update kubeconfig
aws eks update-kubeconfig \
  --name "eks-${ENVIRONMENT}-cluster" \
  --region "$REGION"

# Create namespace if it doesn't exist
kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

# Deploy with Helm
echo "📊 Deploying Helm chart..."
helm upgrade --install sample-api deployments/helm/sample-api \
  --namespace "$NAMESPACE" \
  --values deployments/helm/sample-api/values.yaml \
  --values "deployments/helm/sample-api/values-${ENVIRONMENT}.yaml" \
  --wait \
  --timeout 5m

# Verify deployment
echo "✅ Verifying deployment..."
kubectl rollout status deployment/sample-api -n "$NAMESPACE" --timeout=5m

echo "🎉 Deployment completed successfully!"
kubectl get all -n "$NAMESPACE"
