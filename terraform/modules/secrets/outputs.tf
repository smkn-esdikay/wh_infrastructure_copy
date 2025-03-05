output secrets_key_arn {
  value = aws_kms_key.secrets_key.arn
}

output secrets_arn {
  value = aws_secretsmanager_secret.default.arn
}
