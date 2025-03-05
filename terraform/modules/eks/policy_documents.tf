data "aws_iam_policy_document" "cert_manager" {
  statement {
    actions = [
      "route53:GetChange"
    ]

    resources = [
      "arn:aws:route53:::change/*",
    ]
  }
  statement {
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets"
    ]

    resources = [
      "arn:aws:route53:::hostedzone/*"
    ]
  }
  statement {
    actions = ["route53:ListHostedZonesByName"]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "flux_policy" {
  statement {
    actions = [
      "kms:Describe*",
      "kms:List*",
      "kms:Get*",
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:DescribeKey",
    ]

    resources = [
      aws_kms_key.flux.arn
    ]
  }
}

data "aws_iam_policy_document" "ecr_policy" {
  statement {
    actions = [
      "ecr:*"
    ]

    resources = [
      "*"
    ]
  }
}
