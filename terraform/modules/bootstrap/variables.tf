variable aws_root_account_id {
  description = "AWS root Account ID"
}

variable additional_terraform_provisioner_allow_actions_list {
  description = "allow actions given to terraform provisioner that may be unique per environment"
  default     = []
}
