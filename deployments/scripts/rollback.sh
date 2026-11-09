#!/bin/bash
set -e

echo "🔄 Rolling back deployment..."

ENVIRONMENT=${1:-staging}
NAMESPACE=${ENVIRONMENT}

echo "📦 Environment: $ENVIRONMENT"

# Get previous revision
PREVIOUS_REVISION=$(helm history sample-api -n "$NAMESPACE" --max 2 | tail -1 | awk '{print $1}')

echo "⏮️  Rolling back to revision: $PREVIOUS_REVISION"

helm rollback sample-api "$PREVIOUS_REVISION" \
  --namespace "$NAMESPACE" \
  --wait \
  --timeout 5m

# Verify rollback
kubectl rollout status deployment/sample-api -n "$NAMESPACE" --timeout=5m

echo "✅ Rollback completed successfully!"
