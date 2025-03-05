resource "aws_vpc_peering_connection" "peer" {
  peer_owner_id = var.peer_owner_id
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.requester_vpc_id
  peer_region   = var.peer_region

  tags = {
    Name = "${var.requester_environment}-${var.peer_environment}"
    Side = "Requester"
  }
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept               = true

  tags = {
    Name = "${var.requester_environment}-${var.peer_environment}"
    Side = "Accepter"
  }
}
