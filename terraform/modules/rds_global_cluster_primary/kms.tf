resource "aws_kms_key" "default" {
  description         = "Key for DB Storage Encryption"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.default.json

  tags = local.global_tags
}

resource "aws_kms_alias" "default" {
  name          = "alias/${local.cluster_identifier}_rds_encryption"
  target_key_id = aws_kms_key.default.key_id
}

data "aws_iam_policy_document" "default" {
  statement {
    sid    = "Enable IAM Permissions to Key Creator"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        var.storage_key_admin_arn,
        "*" # TODO
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
      "kms:TagResource",
    ]

    resources = [
      "*"
    ]
  }
}
