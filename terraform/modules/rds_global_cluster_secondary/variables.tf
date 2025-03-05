variable global_cluster_identifier {
  description = "Global Cluster to associate with"
  type        = string
}

variable source_region {
  description = "Region of primary database cluster"
  type        = string
}

variable engine {
  description = "Database Engine Version"
  type        = string
}

variable engine_version {
  description = "database Version"
  type        = string
}

variable backup_retention_period {
  description = "Number of days to retain backups for"
  type        = number
  default     = 7
}

variable cluster_size {
  description = "Number of instances"
  type        = number
  default     = 1
}

variable instance_class {
  description = "aws instance class"
  type        = string
  default     = "db.r4.large"
}

variable environment {
  description = "environment"
  type        = string
}

variable db_subnet_ids {
  description = "VPC subnet IDs that house cluster endpoints"
  type        = list(string)
}

variable availability_zones {
  description = "availability zones that db instances can be provisioned in"
  type        = list(string)
}

variable storage_key_admin_arn {
  description = "AWS ARN used for user/role to manage rds storage encryption key"
  type        = string
}
