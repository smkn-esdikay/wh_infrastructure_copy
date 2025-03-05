data "aws_iam_policy_document" "core_infra_provisioner_policy" {
  statement {
    effect = "Allow"

    actions = concat(
      local.networking_policies,
      local.eks_policies,
      local.route53_policies,
      local.ecr_policies,
      local.s3_policies,
      local.cloudfront_policies,
      local.iam_policies,
      var.additional_terraform_provisioner_allow_actions_list,
    )

    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "flux_policy" {
  statement {
    effect = "Allow"
    actions = [
      "kms:Describe*",
      "kms:List*",
      "kms:Get*",
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]

    resources = [
      "*"
    ]
  }
}
