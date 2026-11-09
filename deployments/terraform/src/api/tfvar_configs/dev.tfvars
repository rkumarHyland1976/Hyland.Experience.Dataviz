environment      = "dev"
eks_cluster_name = "eks-dev-cluster"
replicas         = 2

database = {
  engine                = "postgres"
  engine_version        = "16.1"
  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  max_allocated_storage = 100
  multi_az              = false
}

enable_monitoring  = true
enable_encryption  = true
log_retention_days = 7

tags = {
  Environment = "dev"
  Project     = "SampleProject"
  ManagedBy   = "Terraform"
  CostCenter  = "Engineering"
}
