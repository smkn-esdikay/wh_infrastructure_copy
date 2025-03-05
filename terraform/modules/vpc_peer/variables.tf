variable peer_owner_id {
  description = "aws account id of peer VPC owner"
}

variable peer_vpc_id {
  description = "id of peer VPC"
}

variable peer_vpc_cidr {
  description = "cidr block of peer VPC"
}

variable peer_region {
  description = "region of peer VPC"
}

variable peer_environment {
  description = "environment name of peer VPC"
}

variable peer_route_table_ids {
  description = "route tables of peer account to route to peering connection"
}

variable requester_environment {
  description = "environment name of requester VPC"
}

variable requester_vpc_id {
  description = "id of requester VPC"
}

variable requester_vpc_cidr {
  description = "cidr block of requester VPC"
}

variable requester_route_table_ids {
  description = "route tables of requester account to route to peering connection"
}
