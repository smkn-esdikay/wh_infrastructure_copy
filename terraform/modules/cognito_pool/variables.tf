variable name {
  type = string
}

variable user_name_case_sensitive {
  type = bool
  default = false
}

// GENERAL SETTINGS >> POLICIES
variable "password_minimum_length" {
  description = "Minimum length of the password policy that you have set."
  type        = number
  default     = 12
}

variable "password_require_lowercase" {
  description = "Whether you have required users to use at least one lowercase letter in their password."
  type        = bool
  default     = true
}

variable "password_require_numbers" {
  description = "Whether you have required users to use at least one number in their password."
  type        = bool
  default     = true
}

variable "password_require_symbols" {
  description = "Whether you have required users to use at least one symbol in their password."
  type        = bool
  default     = true
}

variable "password_require_uppercase" {
  description = "Whether you have required users to use at least one uppercase letter in their password."
  type        = bool
  default     = true
}

variable "password_temporary_expiration" {
  description = "The number of days a temporary password is valid. If the user does not sign-in during this time, their password will need to be reset by an administrator."
  type        = number
  default     = 7
}

variable "mfa_enabled" {
  description = "Multi-Factor Authentication (MFA) configuration. Valid values are `OFF`, `ON`, or `OPTIONAL`. Values `ON` and `OPTIONAL` require at least one of resources `sms_configuration` or `software_token_mfa_configuration`"
  type        = string
  default     = "OPTIONAL" // "ON"
}

variable "mfa_software_token_enabled" {
  description = "Boolean whether to enable software token Multi-Factor (MFA) tokens, such as Time-based One-Time Password (TOTP)."
  type        = bool
  default     = true
}

variable "user_attribute_schema" {
  description = "List of objects representing schema for standard attributes required for users. Each map requires keys `name` (string), `attribute_data_type` (string), `developer_only_attribute` (bool), `mutable` (bool), `required` (bool), `max_length` (string), and `min_length` (string)."
  type        = list(any)
  default = [
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
  ]
}

variable "account_recovery_mechanisms" {
  description = "List of strings representing enabled account recovery methods, in order of decreasing priority. Valid values are `verified_email`, `verified_phone_number`, and `admin_only`."
  type        = list(string)
  default = [
    "verified_email"
  ]
}

variable "auto_verified_attributes" {
  description = "List of user attributes which are automatically verified. Valid values include `email` and `phone_number`."
  type        = list(string)
  default     = ["email"]
}

variable "sns_external_id" {
  description = "External ID used to authenticate SNS service via IAM role trust relationship."
  type        = string
}

variable "sns_iam_role" {
  description = "Name of IAM role created to enable SMS messages via AWS SNS."
  type        = string
}

variable "sns_iam_path" {
  description = "Path prefix to the IAM policy or role identifier."
  type        = string
  default     = "/"
}

variable "advanced_security_mode" {
  description = "Mode for advanced security, must be one of OFF, AUDIT or ENFORCED."
  type        = string
  default     = "AUDIT"
}

// GENERAL SETTINGS > MESSAGE CUSTOMIZATIONS
variable "ses_configuration_set" {
  description = "Email configuration set name from SES."
  type        = string
  default     = null
}

variable "ses_sending_account" {
  description = "Email delivery method to use. COGNITO_DEFAULT for the default email functionality built into Cognito or DEVELOPER to use your Amazon SES configuration."
  type        = string
  default     = "COGNITO_DEFAULT"
}

variable "ses_from_email_address" {
  description = "Sender's email address or sender’s display name with their RFC5322-compliant email address (e.g. \"John Smith Ph.D.\" <john@example.com>)."
  type        = string
  default     = null
}

variable "ses_reply_to_email_address" {
  description = "REPLY-TO email address."
  type        = string
  default     = null
}

// TODO (@adysart): convert to data source
variable "ses_source_arn" {
  description = "ARN of the SES verified email identity to to use. Required if email_sending_account is set to DEVELOPER."
  type        = string
  default     = null
}

variable "email_verification_default_email_option" {
  description = "Default email option. Must be either CONFIRM_WITH_CODE or CONFIRM_WITH_LINK."
  type        = string
  default     = "CONFIRM_WITH_LINK"
}

variable "email_verification_subject" {
  description = "Subject line for the email message template."
  type        = string
  default     = "Your verification code"
}

variable "email_verification_subject_by_link" {
  description = "Subject line for the email message template for sending a confirmation link to the user."
  type        = string
  default     = "Your verification link"
}

variable "email_verification_message" {
  description = "Email message template. Must contain the {####} placeholder. Conflicts with email_verification_message argument."
  type        = string
  default     = "Your verification code is {####}. "
}

variable "email_verification_message_by_link" {
  description = "Email message template for sending a confirmation link to the user, it must contain the {##Click Here##} placeholder."
  type        = string
  default     = "Please click the link below to verify your email address. {##Verify Email##} "
}

variable "sms_verification_message" {
  description = "SMS message template. Must contain the {####} placeholder."
  type        = string
  default     = "Your verification code is {####}. "
}

variable "allow_admin_create_user_only" {
  description = "Set to True if only the administrator is allowed to create user profiles. Set to False if users can sign themselves up via an app."
  type        = bool
  default     = true
}

variable "email_invitation_subject" {
  description = "Subject line for email messages."
  type        = string
  default     = "Welcome to AWS Cognito App Client."
}

variable "email_invitation_message" {
  description = "Message template for email messages. Must contain {username} and {####} placeholders, for username and temporary password, respectively."
  type        = string
  default     = "Your username is {username} and temporary password is: {####}"
}

variable "sms_invitation_message" {
  description = "Message template for SMS messages. Must contain {username} and {####} placeholders, for username and temporary password, respectively."
  type        = string
  default     = "Your username is {username} and temporary password is: {####}"
}

variable "tags" {
  description = "Tags attached to AWS resources."
  type        = map(string)
  default = {
    is_terraform_managed = true
  }
}

variable "subdomain_name" {
  description = "Subdomain name for this AWS Cognito user pool."
  type        = string
}

variable "sms_authentication_message" {
  description = " String representing the SMS authentication message. The Message must contain the {####} placeholder, which will be replaced with the code."
  type        = string
  default     = "Your authentication code is {####}. "
}

variable project {
  type = string
}
