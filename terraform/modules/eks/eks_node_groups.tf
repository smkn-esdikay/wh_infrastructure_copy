# TODO
# support for launch_templates in eks was only added in Aug 2020.
# launch_templates must be provided for eks to encrypt the root volumes of the nodes,
# but launch_templates do not support RequestSpotInstances
# see https://docs.aws.amazon.com/eks/latest/APIReference/API_LaunchTemplateSpecification.html
# workaround is to create the node_group, then edit the associated
# ASG's "Purchase options and instance types" with weights of 1 per instance

resource "aws_eks_node_group" "default" {
  count           = length(var.private_subnets)
  cluster_name    = aws_eks_cluster.default.name
  node_group_name = var.private_subnets[count.index]
  node_role_arn   = var.node_role_arn
  subnet_ids      = [var.private_subnets[count.index]]
  ami_type        = "AL2_x86_64"
  version         = var.kubernetes_version

  scaling_config {
    desired_size = var.initial_node_group_size
    max_size     = var.max_node_group_size
    min_size     = var.min_node_group_size
  }

  launch_template {
    id      = aws_launch_template.default.id
    version = aws_launch_template.default.default_version
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = local.global_tags
}

resource "aws_eks_node_group" "gpu" {
  count = var.enable_gpu ? 1 : 0
  cluster_name    = aws_eks_cluster.default.name
  node_group_name = "gpu"
  node_role_arn   = var.node_role_arn
  subnet_ids      = [var.private_subnets[1]]
  ami_type        = "AL2_x86_64_GPU"
  version         = var.kubernetes_version

  scaling_config {
    desired_size = var.initial_gpu_node_group_size
    max_size     = var.max_gpu_node_group_size
    min_size     = var.min_gpu_node_group_size
  }

  launch_template {
    id      = aws_launch_template.gpu.id
    version = aws_launch_template.gpu.default_version
  }

  labels = {
    gpu = true
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = local.global_tags
}
