# RDS Database Instance
resource "aws_db_subnet_group" "api" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = data.aws_subnets.private.ids

  tags = merge(var.tags, {
    Name = "${var.project_name}-db-subnet-group"
  })
}

resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Security group for RDS"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.eks_worker.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-rds-sg"
  })
}

resource "aws_db_instance" "api" {
  identifier            = "${var.project_name}-db"
  engine                = var.database.engine
  engine_version        = var.database.engine_version
  instance_class        = var.database.instance_class
  allocated_storage     = var.database.allocated_storage
  max_allocated_storage = var.database.max_allocated_storage
  storage_encrypted     = var.enable_encryption
  
  db_name  = "sampledb"
  username = "dbadmin"
  password = random_password.db_password.result

  db_subnet_group_name   = aws_db_subnet_group.api.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  
  multi_az               = var.database.multi_az
  skip_final_snapshot    = var.environment != "production"
  final_snapshot_identifier = "${var.project_name}-db-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"

  enabled_cloudwatch_logs_exports = ["postgresql"]
  backup_retention_period         = var.environment == "production" ? 30 : 7
  backup_window                   = "03:00-04:00"
  maintenance_window              = "sun:04:00-sun:05:00"

  tags = merge(var.tags, {
    Name = "${var.project_name}-db"
  })
}

resource "random_password" "db_password" {
  length  = 32
  special = true
}

resource "aws_secretsmanager_secret" "db_password" {
  name_prefix = "${var.project_name}-db-password-"
  description = "RDS database password for ${var.project_name}"

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id = aws_secretsmanager_secret.db_password.id
  secret_string = jsonencode({
    username = aws_db_instance.api.username
    password = random_password.db_password.result
    host     = aws_db_instance.api.address
    port     = aws_db_instance.api.port
    dbname   = aws_db_instance.api.db_name
  })
}

# Data sources
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "eks_worker" {
  name        = "${var.project_name}-eks-worker-sg"
  description = "Security group for EKS workers"
  vpc_id      = data.aws_vpc.default.id

  tags = merge(var.tags, {
    Name = "${var.project_name}-eks-worker-sg"
  })
}

output "rds_endpoint" {
  value       = aws_db_instance.api.endpoint
  description = "RDS endpoint"
  sensitive   = true
}

output "db_secret_arn" {
  value       = aws_secretsmanager_secret.db_password.arn
  description = "ARN of the database password secret"
}
