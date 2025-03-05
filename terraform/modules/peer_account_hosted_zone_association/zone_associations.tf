resource "aws_route53_zone_association" "peer" {
  provider = aws.peer

  vpc_id  = aws_route53_vpc_association_authorization.peer.vpc_id
  zone_id = aws_route53_vpc_association_authorization.peer.zone_id
}
