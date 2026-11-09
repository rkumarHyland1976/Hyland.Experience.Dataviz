environment = "staging"
eks_cluster_name = "eks-staging-cluster"
replicas = 3

database = {
  engine                = "postgres"
  engine_version        = "16.1"
  instance_class        = "db.t3.small"
  allocated_storage     = 50
  max_allocated_storage = 200
  multi_az              = true
}

enable_monitoring = true
enable_encryption = true
log_retention_days = 14

tags = {
  Environment = "staging"
  Project     = "SampleProject"
  ManagedBy   = "Terraform"
  CostCenter  = "Engineering"
}
