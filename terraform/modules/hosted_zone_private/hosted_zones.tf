resource "aws_route53_zone" "subdomain" {
  name = "${var.subdomain}.${var.domain}.${var.top_level_domain}"
  vpc {
    vpc_id = var.vpc_id
  }

  lifecycle {
    ignore_changes = [vpc]
  }
}
