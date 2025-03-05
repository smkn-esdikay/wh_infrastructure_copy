resource "aws_kms_key" "eks" {
  description         = "KMS key to encrypt and decrypt EKS/kubernetes secrets"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.eks_kms_policy.json

  tags = local.global_tags
}

resource "aws_kms_alias" "eks" {
  name          = "alias/eks"
  target_key_id = aws_kms_key.eks.key_id
}

data "aws_iam_policy_document" "eks_kms_policy" {
  statement {
    sid    = "Enable IAM Permissions to eks controlplane"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        var.kms_key_admin_arn,
        var.autoscaling_service_role_arn,
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/CoreInfraRole",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
      ]
    }

    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
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

  statement {
    # Allow attachment of persistent resources by eks
    actions = [
      "kms:CreateGrant"
    ]
    principals {
      type = "AWS"
      identifiers = [
        var.autoscaling_service_role_arn,
        var.eks_cluster_assume_role_arn,
        var.kms_key_admin_arn,
      ]
    }
    resources = [
      "*",
    ]
    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }

  statement {
    # Allow service-linked role use of the CMK
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    principals {
      type = "AWS"
      identifiers = [
        var.autoscaling_service_role_arn,
        var.eks_cluster_assume_role_arn,
      ]
    }
    resources = [
      "*",
    ]
  }
}

resource "aws_kms_key" "flux" {
  description         = "Key used to encrypt/decrypt secrets for flux"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.flux_admin.json
  tags                = local.global_tags

}

resource "aws_kms_alias" "flux" {
  name          = "alias/flux"
  target_key_id = aws_kms_key.flux.key_id
}

data "aws_iam_policy_document" "flux_admin" {
  statement {
    sid    = "Enable IAM Permissions to Key Creator"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        var.kms_key_admin_arn,
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
        "arn:aws:iam::00001:user/mm",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/OrganizationAccountAccessRole",
      ]
    }

    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
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
