module private_hosted_zone {
  source = "../../modules/hosted_zone_private"
  vpc_id = module.networking_us_east_1.vpc_id
  subdomain = "production"
}

output private_hosted_zone_name_servers {
  value = module.private_hosted_zone.hosted_zone_name_servers
}

output private_hosted_zone_zone_id {
  value = module.private_hosted_zone.hosted_zone_id
}

module private_hosted_zone_us_east_1 {
  source = "../../modules/hosted_zone_private"
  vpc_id = module.networking_us_east_1.vpc_id
  subdomain = "us-east-1.production"
}

output private_hosted_zone_us_east_1_name_servers {
  value = module.private_hosted_zone_us_east_1.hosted_zone_name_servers
}

output private_hosted_zone_us_east_1_zone_id {
  value = module.private_hosted_zone_us_east_1.hosted_zone_id
}
