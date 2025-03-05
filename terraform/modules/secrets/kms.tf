resource "aws_kms_key" "secrets_key" {
  description         = "KMS key to encrypt/decrypt secret values"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.secrets_key.json

  tags = local.global_tags
}

resource "aws_kms_alias" "secrets_key" {
  name          = "alias/${var.secret_name}"
  target_key_id = aws_kms_key.secrets_key.key_id
}

data "aws_iam_policy_document" "secrets_key" {
  statement {
    sid    = "Enable IAM Permissions to Key Creator"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        var.kms_key_admin_arn,
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
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid    = "Allows Using Key for Decryption"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.kms_key_decrypt_arns
    }

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "*"
    ]

    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["secretsmanager.${var.secretmanager_region}.amazonaws.com"]
    }
  }
}
