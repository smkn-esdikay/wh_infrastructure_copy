variable peer_vpc_id {
  description = "ID of peered VPC to associate with the hosted zone"
  type        = string
}

variable peer_vpc_region {
  description = "Region of peered VPC to associate with the hosted zone"
  type        = string
}

variable zone_id {
  description = "Local Route53 Hosted Zone ID"
  type        = string
}
