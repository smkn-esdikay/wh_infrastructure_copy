variable "name" {
  description = "Name of this AWS Cognito application client."
  type        = string
}

variable "user_pool_id" {
  description = "ID identifier for associated AWS Cognito user pool."
  type        = string
}

variable "generate_secret" {
  description = "Should an application secret be generated"
  type        = bool
  default     = true
}

variable "refresh_token_validity" {
  description = "Time limit in days refresh tokens are valid for."
  type        = number
  default     = 30
}

variable "refresh_token_units" {
  description = "Time unit in for the value in refresh_token_validity, defaults to days."
  type        = string
  default     = "days" // tfsec:ignore:GEN001
}

variable "access_token_validity" {
  description = "Time limit, between 5 minutes and 1 day, after which the access token is no longer valid and cannot be used. This value will be overridden if you have entered a value in token_validity_units."
  type        = number
  default     = 60
}

variable "access_token_units" {
  description = "Time unit in for the value in access_token_validity, defaults to hours."
  type        = string
  default     = "minutes" // tfsec:ignore:GEN001
}

variable "id_token_validity" {
  description = "Time limit, between 5 minutes and 1 day, after which the ID token is no longer valid and cannot be used. This value will be overridden if you have entered a value in token_validity_units."
  type        = number
  default     = 60
}

variable "id_token_units" {
  description = "Time unit in for the value in id_token_validity, defaults to hours."
  type        = string
  default     = "minutes" // tfsec:ignore:GEN001
}

// GENERAL SETTINGS > APP CLIENT > AUTH FLOW CONFIGURATION
variable "explicit_auth_flows" {
  description = "List of enabled authentication flows. Valid values are ADMIN_NO_SRP_AUTH, CUSTOM_AUTH_FLOW_ONLY, USER_PASSWORD_AUTH, ALLOW_ADMIN_USER_PASSWORD_AUTH, ALLOW_CUSTOM_AUTH, ALLOW_USER_PASSWORD_AUTH, ALLOW_USER_SRP_AUTH, ALLOW_REFRESH_TOKEN_AUTH."
  type        = list(string)
  default = [
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
  ]
}

// GENERAL SETTINGS > APP CLIENT > SECURITY CONFIGURATION
variable "prevent_user_existence_errors" {
  description = "Choose which errors and responses are returned by Cognito APIs during authentication, account confirmation, and password recovery when the user does not exist in the user pool. When set to ENABLED and the user does not exist, authentication returns an error indicating either the username or password was incorrect, and account confirmation and password recovery return a response indicating a code was sent to a simulated destination. When set to LEGACY, those APIs will return a UserNotFoundException exception if the user does not exist in the user pool."
  type        = string
  default     = "ENABLED"
}

variable "client_read_attributes" {
  description = "List of user pool attributes the application client can read from."
  type        = list(string)
  default = [
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
}

variable "client_write_attributes" {
  description = "List of user pool attributes the application client can write to."
  type        = list(string)
  default = [
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
}

// APP INTEGRATION > APP CLIENT SETTINGS > ENABLED IDENTITY PROVIDERS
variable "client_supported_identity_providers" {
  description = "List of provider names for the identity providers that are supported on this client."
  type        = list(string)
  default = [
    "COGNITO",
  ]
}

// APP INTEGRATION > APP CLIENT SETTINGS > SIGN IN AND SIGN OUT URLS
variable "client_callback_urls" {
  description = "List of allowed callback URLs for the identity providers."
  type        = list(string)
  default     = []
}

variable "client_logout_urls" {
  description = "List of allowed logout URLs for the identity providers."
  type        = list(string)
  default     = []
}

variable "client_oauth_flows_enabled" {
  description = "Whether the client is allowed to follow the OAuth protocol when interacting with Cognito user pools."
  type        = bool
  default     = true
}

variable "allowed_oauth_flows" {
  description = "List of allowed OAuth flows. Valid values are `code`, `implicit`, `client_credentials`."
  type        = list(string)
  default = [
    "code",
    "implicit",
  ]
}

variable "allowed_oauth_scopes" {
  description = "List of allowed OAuth scopes. Valid values are `phone`, `email`, `openid`, `profile`, and `aws.cognito.signin.user.admin`."
  type        = list(string)
  default = [
    "aws.cognito.signin.user.admin",
    "email",
    "openid",
    "phone",
    "profile",
  ]
}

variable "tags" {
  description = "Tags attached to AWS resources."
  type        = map(string)
  default = {
    is_terraform_managed = true
  }
}