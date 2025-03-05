variable vpc_cidr_block {
  description = "ipv4 cidr block for vpc"
}

variable environment {
  description = "aws subaccount name"
}

variable region {
  default     = "us-east-1"
  description = "aws region"
}

variable availability_zones {
  type = list(string)
  description = "AZ's to create subnets in"
}
