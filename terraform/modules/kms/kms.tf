resource "aws_kms_key" "default" {
  description         = var.key_description
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.default.json

  tags = local.global_tags
}

resource "aws_kms_alias" "default" {
  name          = "alias/${var.key_alias}"
  target_key_id = aws_kms_key.default.key_id
}

data "aws_iam_policy_document" "default" {
  statement {
    sid    = "Enable IAM Permissions to Key Creator"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        var.key_admin_arn
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
