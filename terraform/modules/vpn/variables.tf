variable vpn_certificates_key_admin_arn {
  description = "AWS arn for user/role to manage vpn certificates kms key "
}

variable public_subnet_id {
  description = "public subnet id for vpn endpoint"
}

variable authorized_target_network_cidr_map {
  default     = {}
  description = "map of {description: cidr blocks to allow vpn access}"
}

variable routes_map {
  default     = {}
  description = "map of {description: destination cidr}"
}

variable dns_server_ips {
  description = "List of DNS server ips to be used for DNS resolution"
  default     = []
}

variable dns_domains {
  description = "Domains to delegate DNS queries for"
  default     = []
}

variable common_name {
  description = "Common name for generated certs"
}

variable organization_name {
  description = "Organization name for generated certs"
}

variable iam_users {
  description = "List of IAM user names to create configs for"
}
