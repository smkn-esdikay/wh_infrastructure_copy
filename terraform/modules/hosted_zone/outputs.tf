output hosted_zone_id {
  value = aws_route53_zone.subdomain.zone_id
}

output hosted_zone_name_servers {
  value = aws_route53_zone.subdomain.name_servers
}

output name {
  value = "${var.subdomain}.${var.domain}.${var.top_level_domain}"
}
