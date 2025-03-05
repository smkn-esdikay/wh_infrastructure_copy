output "name" {
  description = "Name of this AWS Cognito application client."
  value       = aws_cognito_user_pool_client.this.name
  sensitive   = false
}

output "id" {
  description = "ID identifier for this AWS Cognito application client."
  value       = aws_cognito_user_pool_client.this.id
  sensitive   = false
}

output "user_pool_id" {
  description = "ID identifier for the associated AWS Cognito user pool."
  value       = aws_cognito_user_pool_client.this.user_pool_id
  sensitive   = false
}

output "client_secret" {
  description = "ID identifier for this AWS Cognito user pool."
  value       = aws_cognito_user_pool_client.this.client_secret
  sensitive   = true
}