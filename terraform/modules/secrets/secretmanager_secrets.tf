resource "aws_secretsmanager_secret" "default" {
  name       = var.secret_name
  policy     = data.aws_iam_policy_document.default.json
  kms_key_id = aws_kms_key.secrets_key.key_id
}
