variable environment {
  description = "environment"
  type        = string
}

variable region {
  description = "region"
  type        = string
}

variable allowed_eks_cluster_endpoint_cidr_blocks {
  description = "List of cidr blocks that are allowed access to eks cluster endpoint"
  type        = list(string)
}

variable kubernetes_version {
  default     = "1.18"
  description = "Kubernetes version"
  type        = string
}

variable kms_key_admin_arn {
  description = "AWS arn for user/role to manage kms keys "
  type        = string
}

variable eks_cluster_assume_role_arn {
  description = "Role ARN that allows eks to manage aws resources"
  type        = string
}

variable autoscaling_service_role_arn {
  type = string
  description = "Autoscaling service role ARN"
}

variable initial_node_group_size {
  description = "Initial number of instances for node group"
  type        = number
  default     = 1
}

variable max_node_group_size {
  description = "Maximum number of instances for node group"
  type        = number
  default     = 1
}

variable min_node_group_size {
  description = "Minimum number of instances for node group"
  type        = number
  default     = 1
}

variable node_role_arn {
  description = "AWS arn for role that provides permission to eks node group"
  type        = string
}

variable node_group_disk_size {
  description = "Disk Size in GiB for node group"
  type        = number
  default     = 20
}

variable gpu_node_group_disk_size {
  description = "Disk Size in GiB for GPU node group"
  type        = number
  default     = 20
}

variable node_group_instance_types {
  description = "EC2 instance types to associate with node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable aws_root_account_id {
  type        = string
  description = "AWS root Account ID"
}

variable application_name {
  type = string
  description = "Name for the general Kubernetes application role"
}

variable vpc_id {
  type = string
  description = "VPC ID for K8s"
}

variable public_subnets {
  type = list(string)
  description = "Public K8s subnets"
}

variable private_subnets {
  type = list(string)
  description = "Private K8s subnets"
}

variable enable_gpu {
  default = false
  description = "Enable GPU node group"
}

variable gpu_node_group_instance_types {
  description = "EC2 instance types to associate with GPU node group"
  type        = list(string)
  default     = ["p3.2xlarge"]
}

variable initial_gpu_node_group_size {
  description = "Initial number of instances for GPU node group"
  type        = number
  default     = 0
}

variable max_gpu_node_group_size {
  description = "Maximum number of instances for GPU node group"
  type        = number
  default     = 0
}

variable min_gpu_node_group_size {
  description = "Minimum number of instances for GPU node group"
  type        = number
  default     = 0
}

variable extra_service_account_roles {
  description = "Extra service account roles to create in the form of namespace:saname"
  default = []
}

variable hosted_zone_id{
  type = string
}