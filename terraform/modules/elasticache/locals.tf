locals {
  cluster_id                   = "${var.environment}-${data.aws_region.current.name}"
  redis_parameter_group_family = "redis${var.redis_engine_version}"
  automatic_failover_enabled   = var.cluster_count > 1 ? true : false

  global_tags = {
    Managed = "dev-ops"
  }
}
