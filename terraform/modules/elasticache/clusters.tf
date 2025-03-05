resource random_password redis_password {
  length           = 16
  special          = true
  override_special = "$_!?#&"
}

resource "aws_elasticache_replication_group" "default" {
  replication_group_id          = local.cluster_id
  replication_group_description = "local.cluster_id default cluster"
  engine                        = "redis"
  node_type                     = var.node_type
  parameter_group_name          = aws_elasticache_parameter_group.default.name
  number_cache_clusters         = var.cluster_count
  engine_version                = "6.x"
  port                          = 6379
  transit_encryption_enabled    = true
  at_rest_encryption_enabled    = true
  auth_token                    = random_password.redis_password.result
  automatic_failover_enabled    = local.automatic_failover_enabled
  security_group_ids            = [aws_security_group.elasticache.id]
  subnet_group_name             = aws_elasticache_subnet_group.default.name

  # Ignore initial engine version for minor version updates
  lifecycle {
    ignore_changes = [engine_version]
  }
}
