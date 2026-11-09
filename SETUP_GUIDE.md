# Complete Project Setup & Implementation Guide

## 📋 Prerequisites Checklist

- [ ] .NET 8.0 SDK installed
- [ ] Docker Desktop running
- [ ] Git installed and configured
- [ ] AWS CLI v2 configured with credentials
- [ ] kubectl installed
- [ ] Helm v3.x installed
- [ ] Terraform v1.6+ installed
- [ ] GitHub account with admin access to repository

## 🚀 Complete Setup Steps

### Step 1: Initialize Git Repository (5 minutes)

```bash
cd sample-project-app
git init
git add .
git commit -m "Initial commit: Complete sample project with CI/CD pipelines"
git remote add origin https://github.com/YOUR-ORG/sample-project.git
git push -u origin main
```

### Step 2: Configure GitHub Secrets (10 minutes)

Required secrets for CI/CD pipelines:

**AWS Credentials:**
```
AWS_ROLE_TO_ASSUME: arn:aws:iam::ACCOUNT_ID:role/GithubActionsRole
AWS_REGION: us-east-1
```

**Container Registry:**
```
REGISTRY: ghcr.io
```

**Infrastructure:**
```
TF_STATE_BUCKET: sample-project-terraform-state
EKS_CLUSTER_NAME: eks-prod-cluster
```

**Notifications:**
```
SLACK_WEBHOOK: https://hooks.slack.com/services/YOUR/WEBHOOK/URL
```

**Add secrets:**
```bash
gh secret set AWS_ROLE_TO_ASSUME -b "arn:aws:iam::ACCOUNT_ID:role/GithubActionsRole"
gh secret set AWS_REGION -b "us-east-1"
# ... repeat for all secrets
```

### Step 3: Local Development Setup (15 minutes)

```bash
# Install dependencies
dotnet restore

# Build solution
dotnet build -c Release

# Run all tests
dotnet test

# Start Docker environment
docker-compose up -d

# Verify services
curl http://localhost:8080/health/live
```

### Step 4: AWS Infrastructure Setup (30 minutes)

```bash
# Create S3 bucket for Terraform state
aws s3 mb s3://sample-project-terraform-state-${AWS_ACCOUNT_ID} \
  --region us-east-1

# Enable versioning
aws s3api put-bucket-versioning \
  --bucket sample-project-terraform-state-${AWS_ACCOUNT_ID} \
  --versioning-configuration Status=Enabled

# Create IAM role for GitHub Actions
aws iam create-role \
  --role-name GithubActionsRole \
  --assume-role-policy-document file://github-actions-trust-policy.json

# Deploy infrastructure
cd deployments/terraform/src/api
terraform init \
  -backend-config="bucket=sample-project-terraform-state-${AWS_ACCOUNT_ID}" \
  -backend-config="key=dev/terraform.tfstate" \
  -backend-config="region=us-east-1"

terraform plan -var-file="tfvar_configs/dev.tfvars"
terraform apply -var-file="tfvar_configs/dev.tfvars"
```

### Step 5: Docker Image Build & Push (20 minutes)

```bash
# Build image
docker build -t ghcr.io/your-org/sample-project:latest .

# Login to GitHub Container Registry
echo YOUR_GITHUB_TOKEN | docker login ghcr.io -u YOUR_USERNAME --password-stdin

# Push image
docker push ghcr.io/your-org/sample-project:latest
```

### Step 6: Kubernetes Deployment (15 minutes)

```bash
# Create namespace
kubectl create namespace production

# Create image pull secret
kubectl create secret docker-registry ghcr-secret \
  --docker-server=ghcr.io \
  --docker-username=YOUR_USERNAME \
  --docker-password=YOUR_GITHUB_TOKEN \
  --docker-email=your-email@example.com \
  -n production

# Deploy via Helm
helm install sample-api deployments/helm/sample-api \
  --namespace production \
  --values deployments/helm/sample-api/values-prod.yaml \
  --wait

# Verify deployment
kubectl get pods -n production
kubectl get svc -n production
```

### Step 7: Validation & Testing (20 minutes)

```bash
# Run comprehensive tests
./deployments/scripts/validate-env.sh

# Test API endpoints
curl http://api-url/api/sample
curl -X POST http://api-url/api/sample \
  -H "Content-Type: application/json" \
  -d '{"name":"Test","description":"Test Sample"}'

# Check logs
kubectl logs -f deployment/sample-api -n production

# Monitor metrics
kubectl top nodes
kubectl top pods -n production
```

## 🔧 Configuration Files Guide

### `.github/workflows/ci.yaml`
- Runs on every pull request
- Executes build, tests, code analysis
- Builds Docker image
- Validates infrastructure code
- Uploads artifacts

### `.github/workflows/release.yaml`
- Runs on main branch push
- Deploys to staging/production
- Updates infrastructure with Terraform
- Deploys Kubernetes manifests
- Sends notifications

### `deployments/terraform/`
- **provider.tf**: AWS provider configuration
- **variables.tf**: Variable definitions
- **ecr.tf**: Container registry setup
- **rds.tf**: Database configuration
- **cloudwatch.tf**: Monitoring & alerting

### `deployments/helm/sample-api/`
- **values.yaml**: Default configuration
- **values-staging.yaml**: Staging overrides
- **values-prod.yaml**: Production overrides
- **templates/**: Kubernetes manifests

## 📊 Post-Deployment Monitoring

### Access Dashboards

```bash
# Port forward to Prometheus
kubectl port-forward -n monitoring svc/prometheus 9090:9090

# Port forward to Grafana
kubectl port-forward -n monitoring svc/grafana 3000:3000

# View logs
kubectl logs -f deployment/sample-api -n production

# View events
kubectl get events -n production
```

### Health Checks

```bash
# Liveness probe
curl http://localhost:8080/health/live

# Readiness probe
curl http://localhost:8080/health/ready

# Metrics
curl http://localhost:8080/metrics
```

## 🔄 Common Operations

### Deploy New Version

```bash
# Trigger deployment manually
gh workflow run release.yaml -f environment=production

# Or create a tag
git tag v1.0.1
git push origin v1.0.1
```

### Scale Deployment

```bash
# Manual scaling
kubectl scale deployment sample-api --replicas=5 -n production

# Update HPA settings
kubectl patch hpa sample-api -n production -p \
  '{"spec":{"minReplicas":3,"maxReplicas":15}}'
```

### Rollback Deployment

```bash
# Automatic rollback
./deployments/scripts/rollback.sh production

# Or with Helm directly
helm rollback sample-api 1 -n production
```

### Update Configuration

```bash
# Update ConfigMap
kubectl patch configmap sample-api-config -n production \
  -p '{"data":{"LOG_LEVEL":"Debug"}}'

# Update Secrets
kubectl patch secret sample-api-secrets -n production \
  --type merge -p '{"data":{"CONNECTION_STRING":"..."}}'
```

## 🚨 Troubleshooting

### Pod won't start
```bash
kubectl describe pod POD_NAME -n production
kubectl logs POD_NAME -n production
```

### Database connection issues
```bash
# Check secret
kubectl get secret sample-api-secrets -n production -o yaml

# Verify database
aws rds describe-db-instances --query 'DBInstances[0].Endpoint'
```

### Image pull errors
```bash
# Verify image exists
aws ecr describe-images --repository-name sample-project

# Check credentials
kubectl get secret ghcr-secret -n production -o yaml
```

## ✅ Success Criteria Checklist

- [ ] Git repository initialized and pushed
- [ ] GitHub secrets configured
- [ ] Local development environment running
- [ ] AWS infrastructure deployed
- [ ] Docker image built and pushed
- [ ] Kubernetes cluster accessible
- [ ] Helm deployment successful
- [ ] API responding to requests
- [ ] Health checks passing
- [ ] Logs being collected
- [ ] Monitoring dashboards accessible
- [ ] CI/CD pipeline running successfully
- [ ] Alerts configured and working

## 📞 Getting Help

1. Check logs: `kubectl logs -f deployment/sample-api`
2. Describe resources: `kubectl describe pod POD_NAME`
3. Check events: `kubectl get events`
4. Review GitHub Actions: Check workflow runs in repository
5. See troubleshooting section above

## 🎓 Next Steps

1. Customize domain models in `Domain/Entities/`
2. Implement database migrations
3. Add business logic handlers in `Domain/Services/`
4. Extend API controllers with business logic
5. Add more comprehensive tests
6. Configure monitoring alerts
7. Set up log aggregation
8. Implement CI/CD enhancements
9. Add API versioning
10. Implement caching strategy
