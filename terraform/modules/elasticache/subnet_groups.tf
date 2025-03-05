resource "aws_elasticache_subnet_group" "default" {
  name       = local.cluster_id
  subnet_ids = var.cache_subnet_ids
}
