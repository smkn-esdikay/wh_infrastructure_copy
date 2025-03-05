variable environment {
  description = "environment"
  type        = string
}

variable cache_subnet_ids {
  description = "List of subnet ids for the cache subnet group"
  type        = list(string)
}

variable node_type {
  description = "Cache node type"
  type        = string
  default     = "cache.m4.large"
}

variable redis_engine_version {
  description = "Elasticache redis engine version"
  type        = string
  default     = "6.x"
}

variable cluster_count {
  description = "Number of cache cluster when cluster mode is disabled"
  type        = number
  default     = 1
}

# TODO: Decide if redis cluster mode is needed
#variable replicas_per_node_group {
#  description = "Number of replicas in each node group"
#  type        = number
#  default     = 1
#}
#
#variable number_of_node groups {
#  description = "Number of shards for Redis replication group"
#  type        = number
#  default     = 1
#}
