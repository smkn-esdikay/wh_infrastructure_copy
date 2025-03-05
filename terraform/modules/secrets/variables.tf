variable secret_name {
  description = "Name of secret manager secret"
  type        = string
}

variable secret_description {
  description = "Description of secret"
  type        = string
}

variable secret_map {
  description = "Map of key value pairs to be set in secrets"
  type        = map(string)
  default     = {}
}

variable allowed_full_secret_access_arn {
  description = "User/role arn that is allowed full access to secret"
  type        = string
}

variable allowed_secret_value_getter_arns {
  description = "List of user/role arns that are allowed to get secret value"
  type        = list(string)
  default     = []
}

variable kms_key_admin_arn {
  description = "AWS arn for user/role to manage kms key"
  type        = string
}

variable kms_key_decrypt_arns {
  description = "AWS arns for users/roles that can use kms key to decrypt"
  type        = list(string)
}

variable secretmanager_region {
  description = "AWS region for secretmanager"
  type        = string
  default     = "eu-central-1"
}
