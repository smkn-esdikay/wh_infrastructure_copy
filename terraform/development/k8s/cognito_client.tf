module "cognito_app_client" {
  // tflint-ignore: terraform_module_pinned_source
  source = "../../modules/cognito_app_client"

  // GENERAL SETTINGS > APP CLIENT > GENERAL
  name                  = "${var.project}-${var.environment}"
  user_pool_id          = module.cognito_user_pool.id
  generate_secret       = true
  id_token_validity     = 1      // tfsec:ignore:general-secrets-no-plaintext-exposure
  id_token_units        = "days" // tfsec:ignore:general-secrets-no-plaintext-exposure
  access_token_validity = 1      // tfsec:ignore:general-secrets-no-plaintext-exposure
  access_token_units    = "days" // tfsec:ignore:general-secrets-no-plaintext-exposure

  // GENERAL SETTINGS > APP CLIENT > AUTH FLOW CONFIGURATION
  explicit_auth_flows = [
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
  ]

  // GENERAL SETTINGS > APP CLIENT > SECURITY CONFIGURATION
  prevent_user_existence_errors = "ENABLED"
  client_read_attributes = [
    "address",
    "birthdate",
    "email",
    "email_verified",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "phone_number_verified",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo",
  ]
  client_write_attributes = [
    "address",
    "birthdate",
    "email",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo",
  ]

  // APP INTEGRATION > APP CLIENT SETTINGS > ENABLED IDENTITY PROVIDERS
  client_supported_identity_providers = [
    "COGNITO",
  ]

  // APP INTEGRATION > APP CLIENT SETTINGS > SIGN IN AND SIGN OUT URLS
  client_callback_urls = [
    "https://${var.project}.com/oauth-authorized/AWS%20Cognito",
    "https://${var.project}.com/oauth1/idpresponse",
    "https://${var.project}.auth.us-east-1.amazoncognito.com",
    "https://${var.project}.auth.us-east-1.amazoncognito.com/oauth2/idpresponse",
    "https://${var.project}.auth.us-east-1.amazoncognito.com/saml2/idpresponse"
  ]
  client_logout_urls = [
    "https://${var.project}.auth.us-east-1.amazoncognito.com/logout"
  ]

  client_oauth_flows_enabled = true
  allowed_oauth_flows = [
    "code",
    "implicit",
  ]
  allowed_oauth_scopes = [
    "aws.cognito.signin.user.admin",
    "email",
    "openid",
    "phone",
    "profile",
  ]
}