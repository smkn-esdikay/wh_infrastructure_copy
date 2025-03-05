output endpoint {
  value = aws_elasticache_replication_group.default.primary_endpoint_address
}

output password {
  value     = random_password.redis_password.result
  sensitive = true
}
