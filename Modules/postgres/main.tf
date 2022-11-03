# subnet group
resource "aws_db_subnet_group" "sbg" {
  name       = "${var.environment}-${var.app_name}-sbg"
  subnet_ids = [for i in var.subnets : i]

  tags = {
    Name = "${var.environment}-${var.app_name}-sbg"
  }
}



# parameter group
resource "aws_db_parameter_group" "pg" {
  name   = "${var.environment}-${var.app_name}-pg"
  family = "aurora-postgresql12"

  tags = {
    name = "${var.environment}-${var.app_name}-pg"
  }
}

resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = "${var.environment}-${var.app_name}-db"
  engine                  = var.engine
  engine_version          = var.engine_version
  availability_zones      = [for i in var.az : i]
  database_name           = var.db_username
  master_username         = var.db_username
  master_password         = var.db_password
  backup_retention_period = 5
  # db_cluster_instance_class         = "${var.db_instance_type}"
  db_subnet_group_name             = aws_db_subnet_group.sbg.name
  db_instance_parameter_group_name = aws_db_parameter_group.pg.name
  port                             = var.db_port
  vpc_security_group_ids           = [for i in var.sg : i]
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  identifier              = "${var.environment}-${var.app_name}-db"
  cluster_identifier      = aws_rds_cluster.postgresql.id
  instance_class          = var.db_instance_type
  engine                  = aws_rds_cluster.postgresql.engine
  engine_version          = aws_rds_cluster.postgresql.engine_version
  db_subnet_group_name    = aws_db_subnet_group.sbg.name
  db_parameter_group_name = aws_db_parameter_group.pg.name
  tags = {
    "Name" = "${var.environment}-${var.app_name}-db"
  }
}