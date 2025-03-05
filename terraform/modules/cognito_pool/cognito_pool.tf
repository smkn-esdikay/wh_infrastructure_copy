resource "aws_cognito_user_pool" "this" {
  name = var.name

  // GENERAL SETTINGS >> ATTRIBUTES
  username_configuration {
    case_sensitive = var.user_name_case_sensitive
  }

  dynamic "schema" {
    for_each = local.user_attribute_schema
    content {
      name                     = schema.value["name"]
      attribute_data_type      = schema.value["attribute_data_type"]
      developer_only_attribute = schema.value["developer_only_attribute"]
      mutable                  = schema.value["mutable"]
      required                 = schema.value["required"]
      dynamic "string_attribute_constraints" {
        for_each = schema.value["attribute_data_type"] == "String" ? { required = true } : {}
        content {
          max_length = schema.value["max_length"]
          min_length = schema.value["min_length"]
        }
      }
    }
  }

  // GENERAL SETTINGS >> POLICIES
  password_policy {
    minimum_length                   = var.password_minimum_length
    require_lowercase                = var.password_require_lowercase
    require_numbers                  = var.password_require_numbers
    require_symbols                  = var.password_require_symbols
    require_uppercase                = var.password_require_uppercase
    temporary_password_validity_days = var.password_temporary_expiration
  }

  // GENERAL SETTINGS >> MFA AND VERIFICATIONS
  mfa_configuration = var.mfa_enabled

  dynamic "software_token_mfa_configuration" {
    for_each = var.mfa_enabled != "OFF" ? { enabled = true } : {}
    content {
      enabled = var.mfa_software_token_enabled
    }
  }

  dynamic "account_recovery_setting" {
    for_each = local.account_recovery_settings
    content {
      dynamic "recovery_mechanism" {
        for_each = local.account_recovery_mechanisms
        content {
          name     = recovery_mechanism.value["name"]
          priority = recovery_mechanism.value["priority"]
        }
      }
    }
  }

  auto_verified_attributes = var.auto_verified_attributes

  sms_configuration {
    external_id    = var.sns_external_id
    sns_caller_arn = aws_iam_role.sns.arn
  }

  // GENERAL SETTINGS > ADVANCED SECURITY
  user_pool_add_ons {
    advanced_security_mode = var.advanced_security_mode
  }

  // GENERAL SETTINGS > MESSAGE CUSTOMIZATIONS
  email_configuration {
    configuration_set      = var.ses_configuration_set
    email_sending_account  = var.ses_sending_account
    from_email_address     = var.ses_from_email_address
    reply_to_email_address = var.ses_reply_to_email_address
    source_arn             = var.ses_source_arn
  }

  verification_message_template {
    default_email_option  = var.email_verification_default_email_option
    email_subject         = var.email_verification_subject
    email_subject_by_link = var.email_verification_subject_by_link
    email_message         = var.email_verification_message
    email_message_by_link = var.email_verification_message_by_link
    sms_message           = var.sms_verification_message
  }

  sms_authentication_message = var.sms_authentication_message

  admin_create_user_config {
    allow_admin_create_user_only = var.allow_admin_create_user_only
    invite_message_template {
      email_subject = var.email_invitation_subject
      email_message = var.email_invitation_message
      sms_message   = var.sms_invitation_message
    }
  }

  tags = var.tags
}