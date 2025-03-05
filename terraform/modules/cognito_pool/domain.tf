resource "aws_cognito_user_pool_domain" "this" {
  domain       = var.subdomain_name
  user_pool_id = aws_cognito_user_pool.this.id
}