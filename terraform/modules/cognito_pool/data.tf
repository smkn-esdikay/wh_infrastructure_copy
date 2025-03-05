data "aws_iam_policy_document" "sns_trust_relationship" {
  version = "2012-10-17"
  statement {
    sid     = "AllowAWSCognitoToAssumeThisRole"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cognito-idp.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      values   = [var.sns_external_id]
      variable = "sts:ExternalId"
    }
  }
}

data "aws_iam_policy_document" "sns_policy" {
  version = "2012-10-17"
  statement {
    actions = ["sns:publish"]
    effect  = "Allow"
    // tfsec:ignore:aws-iam-no-policy-wildcards
    resources = ["*"]
  }
}