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
  default     = "com"
}

variable primary_vpc_id {
  description = "ID of the VPC to associate"
  type        = string
}

variable primary_vpc_region {
  description = "Region of the VPC to associate"
  type        = string
}

variable secondary_vpcs {
  description = "List of secondary VPC configs to associate with zone"
  type = list(object({
    vpc_id     = string
    vpc_region = string
  }))
  default = []
}
