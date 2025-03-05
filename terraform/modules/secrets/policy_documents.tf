data "aws_iam_policy_document" "default" {

  statement {
    effect = "Allow"
    actions = [
      "secretsManager:*"
    ]
    principals {
      type        = "AWS"
      identifiers = [var.allowed_full_secret_access_arn]
    }
    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "secretsManager:GetSecretValue"
    ]
    principals {
      type        = "AWS"
      identifiers = var.allowed_secret_value_getter_arns
    }
    resources = [
      "*",
    ]

    #condition {
    #  test     = "ForAnyValue:StringEquals"
    #  variable = "secretsmanager:VersionStage"
    #  values   = ["AWSCURRENT"]
    #}
  }
}
