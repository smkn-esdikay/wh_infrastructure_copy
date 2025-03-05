resource "aws_rds_cluster" "default" {
  engine                              = var.engine
  engine_mode                         = "global"
  engine_version                      = var.engine_version
  cluster_identifier                  = local.cluster_identifier
  availability_zones                  = var.availability_zones
  backup_retention_period             = var.backup_retention_period
  global_cluster_identifier           = var.global_cluster_identifier
  skip_final_snapshot                 = true
  kms_key_id                          = aws_kms_key.default.arn
  storage_encrypted                   = true
  db_subnet_group_name                = aws_db_subnet_group.default.name
  source_region                       = var.source_region
  vpc_security_group_ids              = [aws_security_group.rds_database_access.id]
  iam_database_authentication_enabled = true
  tags                                = local.global_tags

  # Ignore arguments without API methods for reading information after creation.
  lifecycle {
    ignore_changes = [
      cluster_identifier,
      db_subnet_group_name,
      engine_mode,
    ]
  }
}
