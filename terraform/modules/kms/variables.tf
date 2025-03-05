variable key_alias {
  description = "Alias of kms Key for conveniance"
  type        = string
}

variable key_description {
  description = "Description of KMS key purpose"
  type        = string
}

variable key_admin_arn {
  description = "AWS arn for user/role to manage kms key"
  type        = string
}
