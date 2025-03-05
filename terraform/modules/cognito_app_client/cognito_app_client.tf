resource "aws_cognito_user_pool_client" "this" {
  // GENERAL SETTINGS > APP CLIENT > GENERAL
  name         = var.name
  user_pool_id = var.user_pool_id

  generate_secret        = var.generate_secret
  refresh_token_validity = var.refresh_token_validity
  access_token_validity  = var.access_token_validity
  id_token_validity      = var.id_token_validity
  token_validity_units {
    refresh_token = var.refresh_token_units
    access_token  = var.access_token_units
    id_token      = var.id_token_units
  }

  // GENERAL SETTINGS > APP CLIENT > AUTH FLOW CONFIGURATION
  explicit_auth_flows = var.explicit_auth_flows

  // GENERAL SETTINGS > APP CLIENT > SECURITY CONFIGURATION
  prevent_user_existence_errors = var.prevent_user_existence_errors
  read_attributes               = var.client_read_attributes
  write_attributes              = var.client_write_attributes

  // APP INTEGRATION > APP CLIENT SETTINGS > ENABLED IDENTITY PROVIDERS
  supported_identity_providers = var.client_supported_identity_providers

  // APP INTEGRATION > APP CLIENT SETTINGS > SIGN IN AND SIGN OUT URLS
  callback_urls = var.client_callback_urls
  logout_urls   = var.client_logout_urls

  // APP INTEGRATION > APP CLIENT SETTINGS > OAUTH 2.0
  allowed_oauth_flows_user_pool_client = var.client_oauth_flows_enabled
  allowed_oauth_flows                  = var.allowed_oauth_flows
  allowed_oauth_scopes                 = var.allowed_oauth_scopes
}