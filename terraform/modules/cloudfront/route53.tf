#resource "aws_route53_record" "cloudfront" {
#  for_each = local.hzs
#  zone_id  = each.value["hosted_zone_id"]
#  name     = "static.${each.key}"
#  records  = [aws_cloudfront_distribution.s3_distribution.domain_name]
#  type     = "CNAME"
#  ttl      = 300
#}
