locals {
  vpc_cidr_block_us_east_1    = "10.108.0.0/16"
  availability_zones = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
  ]

}

module networking_us_east_1 {
  source = "../../modules/networking/"

  vpc_cidr_block = local.vpc_cidr_block_us_east_1
  environment    = local.environment
  region         = "us-east-1"

  availability_zones = local.availability_zones
}

output networking_us_east_1_vpc_id {
  value = module.networking_us_east_1.vpc_id
}

output networking_us_east_1_vpc_cidr_block {
  value = module.networking_us_east_1.cidr_block
}

output networking_us_east_1_route_table_ids {
  value = module.networking_us_east_1.route_table_ids
}
