output hosted_zone_id {
  value = aws_route53_zone.internal.id
}

output hosted_zone_name {
  value = aws_route53_zone.internal.name
}
