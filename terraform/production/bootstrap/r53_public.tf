module public_hosted_zone {
  source = "../../modules/hosted_zone"

  subdomain = "production"
}

output public_hosted_zone_name_servers {
  value = module.public_hosted_zone.hosted_zone_name_servers
}

output public_hosted_zone_id {
  value = module.public_hosted_zone.hosted_zone_id
}

output hosted_zone_name {
  value = module.public_hosted_zone.name
}