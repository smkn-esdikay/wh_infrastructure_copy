# TODO: refactor out in favor of kms module

resource "aws_kms_key" "vpn_certificates" {
  description         = "KMS key to encrypt and decrypt aws client vpn client and server private keys"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.vpn_certificates_key_policy.json

  tags = {
    Managed = "stackoverdrive"
  }
}

resource "aws_kms_alias" "vpn_certificates" {
  name          = "alias/vpn-certificates"
  target_key_id = aws_kms_key.vpn_certificates.key_id
}

data "aws_iam_policy_document" "vpn_certificates_key_policy" {
  statement {
    sid    = "Enable IAM Permissions to Key Creator"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        # TODO
        "*",
        var.vpn_certificates_key_admin_arn
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
