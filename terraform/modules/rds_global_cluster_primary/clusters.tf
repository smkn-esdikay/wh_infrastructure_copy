resource random_password master_password {
  length           = 16
  special          = true
  override_special = "$_!?#&"
}

resource "aws_rds_global_cluster" "default" {
  engine                    = var.engine
  engine_version            = var.engine_version
  global_cluster_identifier = local.global_cluster_identifier
  storage_encrypted         = true
}

resource "aws_rds_cluster" "primary" {
  engine                              = var.engine
  engine_mode                         = "global"
  engine_version                      = var.engine_version
  cluster_identifier                  = local.cluster_identifier
  database_name                       = var.environment
  master_username                     = var.master_username
  master_password                     = random_password.master_password.result
  availability_zones                  = var.availability_zones
  backup_retention_period             = var.backup_retention_period
  global_cluster_identifier           = aws_rds_global_cluster.default.global_cluster_identifier
  skip_final_snapshot                 = true
  kms_key_id                          = aws_kms_key.default.arn
  storage_encrypted                   = true
  db_subnet_group_name                = aws_db_subnet_group.default.name
  vpc_security_group_ids              = [aws_security_group.rds_database_access.id]
  iam_database_authentication_enabled = true
  tags                                = local.global_tags

  # Ignore arguments without API methods for reading information after creation.
  lifecycle {
    ignore_changes = [engine_mode]
  }
}
