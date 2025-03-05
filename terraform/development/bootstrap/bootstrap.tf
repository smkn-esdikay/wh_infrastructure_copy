variable aws_profile {
  default     = "pintv-development-infra"
  description = "AWS profile to bootstrap creation of terraform roles and policies"
}

module bootstrap {
  source      = "../../modules/bootstrap/"
  aws_root_account_id = "00001"
  additional_terraform_provisioner_allow_actions_list = concat(
    local.rds_provisioning_actions,
    local.elasticache_provisioning_actions,
    local.secretmanager_actions,
  )
}

locals {
  rds_provisioning_actions = [
    "rds:CreateGlobalCluster",
    "rds:DeleteGlobalCluster",
    "rds:RemoveFromGlobalCluster",
    "rds:DescribeGlobalClusters",
    "rds:CreateDBSubnetGroup",
    "rds:DeleteDBSubnetGroup",
    "rds:DescribeDBSubnetGroups",
    "rds:AddTagsToResource",
    "rds:ListTagsForResource",
    "rds:CreateDBCluster",
    "rds:DeleteDBCluster",
    "rds:DescribeDBClusters",
    "rds:CreateDBInstance",
    "rds:DeleteDBInstance",
    "rds:DescribeDBInstances",
    "rds:ModifyDBCluster",
    "iam:CreateServiceLinkedRole",
    "iam:DeleteServiceLinkedRole",
    "iam:GetServiceLinkedRoleDeletionStatus",
  ]

  elasticache_provisioning_actions = [
    "elasticache:CreateCacheSubnetGroup",
    "elasticache:CreateCacheParameterGroup",
    "elasticache:CreateCacheSubnetGroup",
    "elasticache:CreateCacheParameterGroup",
    "elasticache:DescribeCacheSubnetGroups",
    "elasticache:DeleteCacheSubnetGroup",
    "elasticache:DescribeCacheParameterGroups",
    "elasticache:DescribeCacheParameters",
    "elasticache:DeleteCacheParameterGroup",
    "elasticache:CreateReplicationGroup",
    "elasticache:DescribeReplicationGroups",
    "elasticache:DescribeCacheClusters",
    "elasticache:ListTagsForResource",
    "elasticache:DeleteReplicationGroup",
    "elasticache:ModifyReplicationGroup",
  ]

  secretmanager_actions = [
    "secretsmanager:*"
  ]
}

output "core_infra_role_arn" {
  value = module.bootstrap.core_infra_role_arn
}

output "autoscaling_service_role_arn" {
  value = module.bootstrap.autoscaling_service_role_arn
}
