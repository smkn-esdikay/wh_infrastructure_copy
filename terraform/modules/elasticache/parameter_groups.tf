resource "aws_elasticache_parameter_group" "default" {
  name   = "redis${replace(var.redis_engine_version, ".", "")}-cache-params"
  family = local.redis_parameter_group_family
}
