locals {
  # mapping role => policies
  roles = {
    # AWS Roles
    "Administrator" = [
      "arn:aws:iam::aws:policy/AdministratorAccess"
    ],
    "pintvRW" = [
      aws_iam_policy.eks_list.arn,
      aws_iam_policy.sops_read.arn,
      aws_iam_policy.sops_write.arn,
      aws_iam_policy.s3_read.arn,
      aws_iam_policy.s3_write.arn
    ],
    "pintvRO" = [
      aws_iam_policy.eks_list.arn,
      aws_iam_policy.sops_read.arn,
      aws_iam_policy.s3_read.arn
    ]

    # Kube Roles - Permissions handled within cluster
    # only required permission is the eks_list
    "KubernetesAdmin" = [
      aws_iam_policy.eks_list.arn
    ],
    "KubernetespintvRW" = [
      aws_iam_policy.eks_list.arn,
    ],
    "KubernetespintvRO" = [
      aws_iam_policy.eks_list.arn,
    ],

  }

  # a mapping of group => roles
  groups = {
    "Administrators" = [
      "Administrator",
      "KubernetesAdmin",
      "pintvRW" # explicit role assumption
    ],
    "KubernetesAdmin" = ["KubernetesAdmin"],
    "pintvRW"       = ["KubernetespintvRW", "pintvRW"],
    "pintvRO"       = ["KubernetespintvRO", "pintvRO"],
  }

  global_tags = {
    Managed = "dev-ops"
  }
}
