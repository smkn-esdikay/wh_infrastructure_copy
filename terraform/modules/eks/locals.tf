locals {
  cluster_name              = "eks-${var.environment}-${var.region}"
  cluster_security_group_id = aws_eks_cluster.default.vpc_config[0].cluster_security_group_id

  internal_domain_root = "pintv-internal.systems"
  external_domain_root = "pintv.systems"
  internal_domain_name = var.environment == "production" ? local.internal_domain_root : "${var.environment}-${var.region}.${local.internal_domain_root}"

  eks_oidc_arr = split("/", aws_eks_cluster.default.identity[0].oidc[0].issuer)
  eks_hash     = local.eks_oidc_arr[length(local.eks_oidc_arr) - 1]

  global_tags = {
    Managed = "dev-ops"
  }

  isra_role_attributes = [
    {
      "name" : aws_iam_role.application.name,
      "arn" : aws_iam_role.application.arn,
    },
    {
      "name" : aws_iam_role.flux.name,
      "arn" : aws_iam_role.flux.arn,
    },
    {
      "name" : aws_iam_role.cert_manager.name,
      "arn" : aws_iam_role.cert_manager.arn,
    },
  ]
}
