resource "aws_route53_zone" "internal" {
  name = "${var.subdomain}.${var.domain}.${var.top_level_domain}"

  vpc {
    vpc_id     = var.primary_vpc_id
    vpc_region = var.primary_vpc_region
  }

  # Ignore changes due to conflict with using route53_zone_association resource that results in perpetual difference in plan output. The route53_zone association is used for cross account vpc zone associations for private hosted zones
  lifecycle {
    ignore_changes = [vpc]
  }
}
