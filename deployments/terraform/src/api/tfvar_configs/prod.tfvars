environment      = "prod"
eks_cluster_name = "eks-prod-cluster"
replicas         = 5

database = {
  engine                = "postgres"
  engine_version        = "16.1"
  instance_class        = "db.t3.medium"
  allocated_storage     = 100
  max_allocated_storage = 500
  multi_az              = true
}

enable_monitoring  = true
enable_encryption  = true
log_retention_days = 30

tags = {
  Environment = "production"
  Project     = "SampleProject"
  ManagedBy   = "Terraform"
  CostCenter  = "Engineering"
  Compliance  = "Required"
}
