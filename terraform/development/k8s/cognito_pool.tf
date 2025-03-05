module "cognito_user_pool" {
  source = "../../modules/cognito_pool"

  // GENERAL SETTINGS >> ATTRIBUTES
  name                     = "${var.project}-${var.environment}"
  user_name_case_sensitive = false
  user_attribute_schema = [
    {
      name                     = "email"
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      required                 = true
      max_length               = "2048"
      min_length               = "0"
    },
    {
      name                     = "phone_number"
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      required                 = true
      max_length               = "2048"
      min_length               = "0"
    },
    {
      name                     = "family_name"
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      required                 = true
      max_length               = "2048"
      min_length               = "0"
    },
    {
      name                     = "given_name"
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      required                 = true
      max_length               = "2048"
      min_length               = "0"
    },
  ]

  // GENERAL SETTINGS >> POLICIES
  password_minimum_length       = 12
  password_require_lowercase    = true
  password_require_numbers      = true
  password_require_symbols      = true
  password_require_uppercase    = true
  password_temporary_expiration = 7
  allow_admin_create_user_only  = true

  // GENERAL SETTINGS >> MFA AND VERIFICATIONS
  mfa_enabled                = "ON"
  mfa_software_token_enabled = true
  account_recovery_mechanisms = [
    "verified_email"
  ]
  auto_verified_attributes = [
    "email"
  ]
  sns_external_id = "6d42608d-3b21-4b93-aa47-3e75ac0ce009"
  project = var.project

  // GENERAL SETTINGS > ADVANCED SECURITY
  advanced_security_mode = "AUDIT"

  // GENERAL SETTINGS > MESSAGE CUSTOMIZATIONS
  ses_sending_account = "COGNITO_DEFAULT"

  email_verification_default_email_option = "CONFIRM_WITH_LINK"
  email_verification_subject              = "Your verification code"
  email_verification_subject_by_link      = "Your verification link"
  email_verification_message              = "Your verification code is {####}."
  email_verification_message_by_link      = "Please click the link below to verify your email address. {##Verify Email##} "
  sms_verification_message                = "Your verification code is {####}."
  sms_authentication_message              = "Your authentication code is {####}."
  email_invitation_subject                = "Welcome to pintv: data services"
  email_invitation_message                = <<EOF
Your username is {username} and temporary password is: {####}

In order to login go to: https://superset.ai.TODO.com

For your first log in: Select Amazon as the login provider and the select register
For future logins: Select Amazon as the login provider and the select "Sign In"
EOF
  sms_invitation_message                  = "Your username is {username} and temporary password is: {####}"

  // DOMAIN
  subdomain_name = "${var.project}"

  // IAM
  sns_iam_role = "${var.project}-SMS-Role"
  sns_iam_path = "/service-role/"

  tags = {
    is_terraform_managed = true
  }
}