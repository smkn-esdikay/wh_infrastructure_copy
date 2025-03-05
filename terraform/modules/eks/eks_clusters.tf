resource "aws_eks_cluster" "default" {
  name     = local.cluster_name
  version  = var.kubernetes_version
  role_arn = var.eks_cluster_assume_role_arn

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = false
    subnet_ids              = concat(var.private_subnets, var.public_subnets)
  }

  enabled_cluster_log_types = ["api", "audit"]

  encryption_config {
    provider {
      key_arn = aws_kms_key.eks.arn
    }
    resources = ["secrets"]
  }

  # log group dependency set to prevent ordering issues leading to naming clashes
  depends_on = [
    aws_cloudwatch_log_group.eks,
  ]

  tags = local.global_tags
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.external.thumbprint.result.thumbprint]
  url             = aws_eks_cluster.default.identity[0].oidc[0].issuer
}
