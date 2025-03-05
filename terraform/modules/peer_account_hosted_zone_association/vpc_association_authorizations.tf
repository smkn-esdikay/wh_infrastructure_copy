resource "aws_route53_vpc_association_authorization" "peer" {
  zone_id    = var.zone_id
  vpc_id     = var.peer_vpc_id
  vpc_region = var.peer_vpc_region
}
