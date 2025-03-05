data "aws_iam_policy_document" "eks_list" {
  statement {
    actions = [
      "eks:DescribeCluster",
      "eks:ListClusters"
    ]

    resources = ["*"]
  }
}

# allows a user to assume the roles for the groups they have been assigned
data "aws_iam_policy_document" "allow_assuming_groups_roles" {
  statement {
    actions = [
      "iam:GetPolicy",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:GetPolicyVersion",
      "iam:ListAttachedRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:ListRoles"
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "sops_write" {
  statement {
    actions = [
      "kms:Encrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
    ]

    resources = var.sops_keys
  }
}

data "aws_iam_policy_document" "sops_read" {
  statement {
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey"
    ]

    resources = var.sops_keys
  }
}


data "aws_iam_policy_document" "s3_write" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = formatlist("arn:aws:s3:::%s/*", var.s3_buckets)
  }
}

data "aws_iam_policy_document" "s3_read" {
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:ListAllMyBuckets"
    ]
    resources = ["*"]
  }
  statement {
    actions = [
      "s3:ListBucket"
    ]
    resources = formatlist("arn:aws:s3:::%s", var.s3_buckets)
  }
  statement {
    actions = [
      "s3:GetObject"
    ]
    resources = formatlist("arn:aws:s3:::%s/*", var.s3_buckets)
  }
}
