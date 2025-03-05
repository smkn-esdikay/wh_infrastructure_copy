resource aws_route peer_routes {
  provider = aws.peer
  count    = length(var.peer_route_table_ids)

  route_table_id            = var.peer_route_table_ids[count.index]
  destination_cidr_block    = var.requester_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource aws_route requester_routes {
  count = length(var.requester_route_table_ids)

  route_table_id            = var.requester_route_table_ids[count.index]
  destination_cidr_block    = var.peer_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
