locals {
  kubernetes_version = "1.31"
}

# Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
# Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
module eks_iam {
  source = "../../modules/eks_iam/"
}

module eks_us_east_1 {
  source = "../../modules/eks/"

  environment        = local.environment
  application_name   = "pintv"
  aws_root_account_id = local.aws_root_account_id
  kubernetes_version = local.kubernetes_version
  region             = "us-east-1"

  kms_key_admin_arn           = data.terraform_remote_state.bootstrap.outputs.core_infra_role_arn
  eks_cluster_assume_role_arn = module.eks_iam.eks_cluster_assume_role_arn
  autoscaling_service_role_arn = data.terraform_remote_state.bootstrap.outputs.autoscaling_service_role_arn

  initial_node_group_size   = 0
  max_node_group_size       = 1
  min_node_group_size       = 0
  node_role_arn             = module.eks_iam.eks_node_group_role_arn
  node_group_disk_size      = 100
  node_group_instance_types = ["r5.large"]
  allowed_eks_cluster_endpoint_cidr_blocks = [
    local.vpc_cidr_block_us_east_1
  ]

  enable_gpu = false
  initial_gpu_node_group_size   = 1
  max_gpu_node_group_size       = 1
  min_gpu_node_group_size       = 1

  public_subnets = module.networking_us_east_1.public_subnet_ids
  private_subnets = module.networking_us_east_1.private_subnet_ids
  vpc_id = module.networking_us_east_1.vpc_id
  hosted_zone_id = data.terraform_remote_state.bootstrap.outputs.public_hosted_zone_id
}

module pod_security_groups_us_east_1 {
  source      = "../../modules/pod_security_groups/"
  environment = local.environment
  vpc_id      = module.networking_us_east_1.vpc_id
}

output application_role_arns {
  value = module.eks_us_east_1.application_role_arns
}
