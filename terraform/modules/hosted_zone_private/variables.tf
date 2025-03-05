variable subdomain {
  description = "Subdomain Name"
  type        = string
}

variable domain {
  description = "Domain Name"
  type        = string
  default     = "pintv"
}

variable top_level_domain {
  description = "Top Level Domain Name"
  type        = string
  default     = "internal"
}

variable vpc_id {
  description = "VPC ID to associate with private zone"
}
