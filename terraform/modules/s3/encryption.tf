data "aws_caller_identity" "current" {}

resource "aws_kms_key" "primary_store" {
  description         = "Used to encrypt/decrypt objects in the primary store"
  enable_key_rotation = true

  policy = jsonencode({
    Id      = "pintv-store-key",
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowUseOfKey",
        Effect = "Allow",
        Principal = {
          AWS = [
            data.aws_caller_identity.current.account_id,
          ]
        },
        Action   = "kms:*",
        Resource = "*"
        }, {
        Sid    = "AllowUseByS3",
        Effect = "Allow",
        Principal = {
          Service = "s3.amazonaws.com"
        },
        Action = [
          "kms:GenerateDataKey",
          "kms:Decrypt"
        ],
        Resource = "*"
      }
    ]
  })
}
