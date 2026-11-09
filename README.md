# Sample .NET API Project

A complete sample .NET API project with production-ready CI/CD pipelines, Docker deployment, Kubernetes orchestration, and Infrastructure as Code (IaC).

## 📋 Quick Start

### Local Development

1. **Prerequisites**
   - .NET 8.0 SDK
   - Docker & Docker Compose
   - Git

2. **Setup**
   ```bash
   # Clone repository
   git clone https://github.com/hyland/sample-project.git
   cd sample-project-app

   # Start Docker services
   docker-compose up -d

   # Restore dependencies
   dotnet restore

   # Build solution
   dotnet build

   # Run tests
   dotnet test

   # Run API
   cd src/Hyland.Experience.SampleProject.Api
   dotnet run
   ```

3. **Access**
   - API: http://localhost:8080
   - Swagger: http://localhost:8080/swagger
   - Jaeger UI: http://localhost:16686

### Docker Build

```bash
# Build image
docker build -t sample-api:latest .

# Run container
docker run -p 8080:8080 sample-api:latest
```

### Kubernetes Deployment

```bash
# Install chart
helm install sample-api deployments/helm/sample-api \
  --namespace production \
  --values deployments/helm/sample-api/values-prod.yaml

# Verify deployment
kubectl get pods -n production
kubectl logs -f deployment/sample-api -n production
```

## 📁 Project Structure

```
sample-project-app/
├── .github/
│   ├── workflows/          # CI/CD pipelines
│   │   ├── ci.yaml        # Pull request checks
│   │   └── release.yaml   # Production deployment
│   └── actions/           # Custom GitHub actions
│
├── src/
│   ├── Domain/            # Domain models & business logic
│   ├── Infrastructure/    # Data access & services
│   └── Api/              # REST API controllers
│
├── test/
│   ├── UnitTests/        # Unit tests
│   └── ComponentTests/   # Integration tests
│
├── deployments/
│   ├── helm/             # Kubernetes Helm charts
│   ├── terraform/        # IaC for AWS infrastructure
│   ├── keda/            # Auto-scaling configuration
│   └── scripts/         # Deployment scripts
│
├── Dockerfile           # Multi-stage build
└── docker-compose.yaml  # Local development environment
```

## 🔄 CI/CD Pipelines

### Pull Request Validation (CI)
- ✅ Build & compile
- ✅ Run unit tests
- ✅ Code quality analysis
- ✅ Security scanning
- ✅ Docker image build
- ✅ Terraform validation
- ✅ Helm chart validation

### Main Branch Deployment (Release)
- ✅ All CI checks
- ✅ Docker image push to ECR
- ✅ Terraform apply
- ✅ Kubernetes deployment
- ✅ Health verification
- ✅ Slack notifications

## 🔧 Configuration

### Environment Variables
See `.env.example` for all available configuration options.

### Database
- PostgreSQL 16.1
- Auto-migrations on startup
- Connection pooling enabled

### Observability
- **Logging**: Serilog with file & console output
- **Tracing**: OpenTelemetry with Jaeger exporter
- **Metrics**: Prometheus format metrics
- **Health Checks**: Live & ready endpoints

## 🚀 Deployment Environments

### Development
- 2 replicas, 250m CPU, 256Mi memory
- Database: Single-AZ, small instance
- Logs retention: 7 days

### Staging
- 3 replicas, 500m CPU, 512Mi memory
- Database: Multi-AZ, medium instance
- Logs retention: 14 days

### Production
- 5+ replicas (auto-scaling up to 20), 1000m CPU, 1024Mi memory
- Database: Multi-AZ, large instance
- Logs retention: 30 days
- Enhanced monitoring & alerting

## 📊 Infrastructure as Code

### Terraform
Manages:
- ECR repository
- RDS PostgreSQL
- CloudWatch logs & alarms
- SNS notifications
- IAM roles & policies

Apply infrastructure:
```bash
cd deployments/terraform/src/api
terraform plan -var-file="tfvar_configs/staging.tfvars"
terraform apply -var-file="tfvar_configs/staging.tfvars"
```

## 🧪 Testing

```bash
# Run all tests
dotnet test

# Run specific project
dotnet test test/Hyland.Experience.SampleProject.Api.UnitTests

# With coverage
dotnet test /p:CollectCoverage=true /p:CoverageFormat=opencover

# Component tests (requires Docker)
docker-compose up -d
dotnet test test/Hyland.Experience.SampleProject.Api.ComponentTests
```

## 📝 API Documentation

- **OpenAPI/Swagger**: http://localhost:8080/swagger
- **Health Check**: http://localhost:8080/health/live
- **Ready Check**: http://localhost:8080/health/ready

## 🔐 Security

- Non-root container user
- Read-only root filesystem
- Security scanning on every build
- Secrets management via AWS Secrets Manager
- RBAC configured in Kubernetes

## 📞 Support

For issues and questions, please refer to:
- GitHub Issues: https://github.com/hyland/sample-project/issues
- Documentation: See `/docs` directory

## 📄 License

This project is licensed under the MIT License.
