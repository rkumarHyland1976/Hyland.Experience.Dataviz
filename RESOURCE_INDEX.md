# 📑 Complete Resource Index

## 📚 Documentation & Guides

### Getting Started
- **[GETTING_STARTED.md](./GETTING_STARTED.md)** ⭐ START HERE
  - 7-phase setup walkthrough
  - Step-by-step implementation checklist
  - Time estimates for each phase
  - Troubleshooting common issues
  - Success criteria and validation

### Project Overview
- **[README.md](./README.md)**
  - Quick start guide
  - Project structure overview
  - API documentation
  - Technology stack
  - Local development setup

- **[PROJECT_SUMMARY.md](./PROJECT_SUMMARY.md)**
  - Architecture overview
  - CI/CD pipeline flows
  - Environment matrix
  - Deployment strategies
  - Configuration reference

### Detailed Implementation
- **[SETUP_GUIDE.md](./SETUP_GUIDE.md)**
  - Phase 1: Environment preparation
  - Phase 2: Project initialization
  - Phase 3: Infrastructure setup
  - Phase 4: Deployment configuration
  - Phase 5: Monitoring setup
  - Phase 6: Documentation
  - Phase 7: Team onboarding
  - Troubleshooting section

---

## 🏗️ Project Structure

### Source Code
```
src/
├── Hyland.Experience.SampleProject.Domain/
│   ├── Domain.csproj
│   ├── Events/
│   │   └── DomainEvent.cs
│   ├── Entities/
│   │   └── Sample.cs
│   └── Repositories/
│       └── ISampleRepository.cs
│
├── Hyland.Experience.SampleProject.Infrastructure/
│   ├── Infrastructure.csproj
│   └── Persistence/
│       └── SampleContext.cs (DbContext + Repository)
│
└── Hyland.Experience.SampleProject.Api/
    ├── Api.csproj
    ├── Program.cs (Startup config)
    ├── Controllers/
    │   └── SampleController.cs (CRUD endpoints)
    ├── appsettings.json
    ├── appsettings.Development.json
    └── appsettings.Production.json
```

### Test Projects
```
test/
├── Hyland.Experience.SampleProject.Api.UnitTests/
│   ├── UnitTests.csproj
│   └── SampleEntityTests.cs
│
└── Hyland.Experience.SampleProject.Api.ComponentTests/
    └── ComponentTests.csproj
```

### Deployment
```
deployments/
├── terraform/
│   ├── provider.tf
│   └── src/api/
│       ├── variables.tf
│       ├── outputs.tf
│       ├── ecr.tf (Container Registry)
│       ├── rds.tf (Database)
│       ├── cloudwatch.tf (Monitoring)
│       └── tfvar_configs/
│           ├── dev.tfvars
│           ├── staging.tfvars
│           └── prod.tfvars
│
├── helm/sample-api/
│   ├── Chart.yaml
│   ├── values.yaml
│   ├── values-staging.yaml
│   ├── values-prod.yaml
│   └── templates/
│       ├── deployment.yaml
│       ├── service.yaml
│       ├── configmap.yaml
│       ├── ingress.yaml
│       ├── hpa.yaml
│       ├── serviceaccount.yaml
│       └── _helpers.tpl
│
└── scripts/
    ├── deploy.sh (Helm deployment)
    ├── rollback.sh (Quick rollback)
    ├── validate-env.sh (Environment checks)
    ├── install-dependencies.sh (Tool setup)
    └── test-local.sh (Local testing)
```

### CI/CD
```
.github/workflows/
├── ci.yaml (Pull request validation)
│   ├── Build
│   ├── Unit tests
│   ├── Code quality
│   ├── Security scanning
│   ├── Docker build
│   ├── Terraform validation
│   ├── Helm validation
│   └── Summary
│
└── release.yaml (Production deployment)
    ├── Prepare
    ├── Test
    ├── Build and push
    ├── Terraform plan
    ├── Terraform apply
    ├── Deploy
    └── Notify
```

### Configuration
```
Root files:
├── .gitignore
├── .dockerignore
├── .env.example
├── config.yaml
├── Dockerfile (Multi-stage build)
├── docker-compose.yaml (Local services)
├── Hyland.Experience.SampleProject.sln (Visual Studio solution)
└── github-actions-trust-policy.json (AWS OIDC)
```

---

## 🔑 Key Files Reference

### Application Entry Point
- **[src/Hyland.Experience.SampleProject.Api/Program.cs](./src/Hyland.Experience.SampleProject.Api/Program.cs)**
  - OpenTelemetry setup (Jaeger tracing)
  - Serilog logging configuration
  - Health check endpoints
  - Database initialization
  - Dependency injection setup

### Data Model
- **[src/Hyland.Experience.SampleProject.Domain/Entities/Sample.cs](./src/Hyland.Experience.SampleProject.Domain/Entities/Sample.cs)**
  - Core domain entity
  - Properties: Id, Name, Description, CreatedAt
  - Domain-driven design pattern

### Database Context
- **[src/Hyland.Experience.SampleProject.Infrastructure/Persistence/SampleContext.cs](./src/Hyland.Experience.SampleProject.Infrastructure/Persistence/SampleContext.cs)**
  - EF Core DbContext
  - Repository pattern implementation
  - Database configuration
  - Migration support

### API Controller
- **[src/Hyland.Experience.SampleProject.Api/Controllers/SampleController.cs](./src/Hyland.Experience.SampleProject.Api/Controllers/SampleController.cs)**
  - CRUD operations: GET, POST, PUT, DELETE
  - OpenAPI/Swagger documentation
  - Error handling
  - Request/response models

### Infrastructure as Code
- **[deployments/terraform/src/api/ecr.tf](./deployments/terraform/src/api/ecr.tf)**
  - AWS ECR repository
  - Lifecycle policies
  - Image tagging strategy

- **[deployments/terraform/src/api/rds.tf](./deployments/terraform/src/api/rds.tf)**
  - PostgreSQL database
  - Multi-AZ configuration
  - Automated backups
  - Secrets Manager integration

- **[deployments/terraform/src/api/cloudwatch.tf](./deployments/terraform/src/api/cloudwatch.tf)**
  - CloudWatch log groups
  - Dashboards
  - SNS alarms
  - Monitoring configuration

### Kubernetes Deployment
- **[deployments/helm/sample-api/templates/deployment.yaml](./deployments/helm/sample-api/templates/deployment.yaml)**
  - Pod specification
  - Container definition
  - Resource limits
  - Health probes
  - Security context

- **[deployments/helm/sample-api/templates/hpa.yaml](./deployments/helm/sample-api/templates/hpa.yaml)**
  - Horizontal Pod Autoscaler
  - Scaling policies
  - Metrics (CPU/Memory)

### CI/CD Pipelines
- **[.github/workflows/ci.yaml](./.github/workflows/ci.yaml)**
  - PR validation pipeline
  - Automated testing
  - Security scanning
  - Build optimization

- **[.github/workflows/release.yaml](./.github/workflows/release.yaml)**
  - Production deployment
  - Terraform automation
  - Kubernetes deployment
  - Health verification

---

## 🎯 Quick Command Reference

### Local Development
```bash
# Restore and build
dotnet restore
dotnet build -c Release

# Run tests
dotnet test

# Start API
cd src/Hyland.Experience.SampleProject.Api
dotnet run

# Start local services
docker-compose up -d
docker-compose logs -f

# Stop services
docker-compose down
```

### Docker
```bash
# Build image
docker build -t sample-api:latest .

# Run container
docker run -p 8080:8080 sample-api:latest

# Push to registry
docker tag sample-api:latest registry/sample-api:latest
docker push registry/sample-api:latest

# Scan image
docker scan sample-api:latest
```

### Infrastructure (Terraform)
```bash
# Initialize
terraform init

# Plan changes
terraform plan -var-file="tfvar_configs/dev.tfvars"

# Apply changes
terraform apply

# Destroy resources
terraform destroy
```

### Kubernetes (Helm)
```bash
# Install release
helm install sample-api deployments/helm/sample-api -n dev

# Upgrade release
helm upgrade sample-api deployments/helm/sample-api -n dev

# Uninstall release
helm uninstall sample-api -n dev

# View values
helm get values sample-api -n dev

# Dry run
helm install sample-api deployments/helm/sample-api --dry-run --debug
```

### Debugging & Monitoring
```bash
# Pod logs
kubectl logs deployment/sample-api -n dev -f

# Pod status
kubectl describe pod <POD_NAME> -n dev

# Port forward
kubectl port-forward svc/sample-api 8080:80 -n dev

# Execute command in pod
kubectl exec -it <POD_NAME> -n dev -- /bin/bash

# View metrics
kubectl top pods -n dev
kubectl top nodes
```

---

## 📋 Environment Variables

### Development (.env.example)
```bash
# API Configuration
ASPNETCORE_ENVIRONMENT=Development
ASPNETCORE_URLS=http://localhost:8080

# Database
DB_HOST=postgres
DB_PORT=5432
DB_NAME=sample_project_db
DB_USER=postgres
DB_PASSWORD=postgres_password

# Redis
REDIS_HOST=redis
REDIS_PORT=6379

# Monitoring
JAEGER_AGENT_HOST=jaeger
JAEGER_AGENT_PORT=6831
OTEL_SERVICE_NAME=sample-api

# Logging
SERILOG_LEVEL=Information
SERILOG_CONSOLE_OUTPUT=true
```

### Production (Kubernetes Secrets)
```bash
ConnectionStrings__DefaultConnection
OTEL_EXPORTER_OTLP_ENDPOINT
JAEGER_AGENT_HOST
REDIS_CONNECTION_STRING
AWS_REGION
AWS_ACCOUNT_ID
```

---

## 🔐 Security Checklist

- [ ] Dockerfile uses non-root user (appuser)
- [ ] Container image scanned for vulnerabilities
- [ ] Kubernetes NetworkPolicy configured
- [ ] Pod Security Policy enforced
- [ ] Database encrypted at rest
- [ ] TLS/SSL certificates configured
- [ ] Secrets stored in AWS Secrets Manager
- [ ] IAM roles follow least privilege
- [ ] API endpoints authenticated/authorized
- [ ] CORS properly configured
- [ ] Input validation implemented
- [ ] SQL injection prevention (EF Core parameterized queries)
- [ ] Rate limiting configured
- [ ] Audit logging enabled

---

## 📊 Technology Stack

### Backend
- **.NET 8.0** - Application framework
- **Entity Framework Core** - ORM
- **PostgreSQL** - Primary database
- **Redis** - Caching & session store

### DevOps & Infrastructure
- **Docker** - Container runtime
- **Kubernetes** - Orchestration
- **Helm** - Package manager
- **Terraform** - Infrastructure as Code
- **AWS** - Cloud provider

### CI/CD
- **GitHub Actions** - Automation
- **SonarQube/CodeQL** - Code quality
- **Grype/Trivy** - Security scanning
- **Semantic Versioning** - Release management

### Monitoring & Observability
- **Jaeger** - Distributed tracing
- **Prometheus** - Metrics
- **Serilog** - Structured logging
- **OpenTelemetry** - Observability framework
- **CloudWatch** - AWS monitoring

### Testing
- **xUnit** - Unit testing
- **FluentAssertions** - Assertions
- **Testcontainers** - Integration testing
- **Mock** - Mocking framework

---

## 📞 Support & Resources

### Official Documentation
- [.NET Documentation](https://docs.microsoft.com/dotnet/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Terraform Documentation](https://www.terraform.io/docs/)
- [GitHub Actions Documentation](https://docs.github.com/actions/)

### Community
- [.NET Discord](https://discord.com/invite/dotnet)
- [Kubernetes Slack](https://kubernetes.slack.com/)
- [Terraform Community](https://discuss.hashicorp.com/c/terraform/)

### Related Guides
- Domain-Driven Design (DDD) patterns
- SOLID principles
- Microservices architecture
- GitOps workflow
- Infrastructure as Code best practices

---

## 🎓 Learning Paths

### For Developers
1. Study [Domain.cs](./src/Hyland.Experience.SampleProject.Domain/Entities/Sample.cs) and [Controller.cs](./src/Hyland.Experience.SampleProject.Api/Controllers/SampleController.cs)
2. Review [Program.cs](./src/Hyland.Experience.SampleProject.Api/Program.cs) for configuration
3. Explore [SampleContext.cs](./src/Hyland.Experience.SampleProject.Infrastructure/Persistence/SampleContext.cs) for data access
4. Study unit tests in [UnitTests](./test/Hyland.Experience.SampleProject.Api.UnitTests/)

### For DevOps Engineers
1. Review [docker-compose.yaml](./docker-compose.yaml) for local setup
2. Study [Dockerfile](./Dockerfile) for containerization
3. Analyze [ci.yaml](./.github/workflows/ci.yaml) and [release.yaml](./.github/workflows/release.yaml) for CI/CD
4. Explore Terraform files in [deployments/terraform](./deployments/terraform/)
5. Review Helm templates in [deployments/helm](./deployments/helm/)

### For Architects
1. Review [PROJECT_SUMMARY.md](./PROJECT_SUMMARY.md) for overall design
2. Study [SETUP_GUIDE.md](./SETUP_GUIDE.md) for implementation strategy
3. Analyze infrastructure patterns in Terraform
4. Review security patterns and compliance

---

## ✅ Verification Checklist

### Initial Setup
- [ ] All files present (112 total)
- [ ] Directory structure complete
- [ ] No build errors
- [ ] All documentation readable

### Local Development
- [ ] `dotnet build` succeeds
- [ ] `dotnet test` passes all tests
- [ ] `docker-compose up` starts all services
- [ ] API accessible at http://localhost:8080
- [ ] Swagger UI loads at /swagger
- [ ] Health checks pass

### Deployment Ready
- [ ] Docker image builds
- [ ] Terraform initializes
- [ ] Helm templates validate
- [ ] CI/CD workflows configured
- [ ] GitHub secrets set
- [ ] AWS credentials available

---

**Last Updated:** 2024
**Version:** 1.0.0
**Status:** Production Ready ✅

---

For questions or issues, refer to the detailed documentation or troubleshooting sections in SETUP_GUIDE.md.
