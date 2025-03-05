resource "aws_route53_zone_association" "secondary" {
  count = length(var.secondary_vpcs)

  zone_id    = aws_route53_zone.internal.id
  vpc_id     = var.secondary_vpcs[count.index].vpc_id
  vpc_region = var.secondary_vpcs[count.index].vpc_region
}
