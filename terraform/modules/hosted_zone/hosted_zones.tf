resource "aws_route53_zone" "subdomain" {
  name = "${var.subdomain}.${var.domain}.${var.top_level_domain}"
}
