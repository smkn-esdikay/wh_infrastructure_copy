variable engine {
  description = "Global Database Engine"
  type        = string
  default     = "aurora-postgresql"
}

variable engine_version {
  description = "Database Engine Version"
  type        = string
  default     = "12.8"
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

variable master_username {
  description = "Database Username"
  type        = string
  default     = "root"
}

variable storage_key_admin_arn {
  description = "AWS ARN used for user/role to manage rds storage encryption key"
  type        = string
}
