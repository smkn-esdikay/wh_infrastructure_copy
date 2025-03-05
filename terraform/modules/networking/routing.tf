resource aws_route_table public {
  tags = merge(
    tomap({"Name" = "public"}),
    local.global_tags
  )
  vpc_id = aws_vpc.primary.id
}

resource aws_route_table main {
  count = length(var.availability_zones)

  tags = merge(
    tomap({"Name" = "${var.environment}_${element(var.availability_zones, count.index)}"}),
    local.global_tags
  )

  vpc_id = aws_vpc.primary.id
}

resource aws_route public_to_internet_gateway {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway.id
  route_table_id         = aws_route_table.public.id
}

resource aws_route az_to_nat_gateway {
  count                  = length(var.availability_zones)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.gateway.*.id, count.index)
  route_table_id         = element(aws_route_table.main.*.id, count.index)
  depends_on             = [aws_nat_gateway.gateway, aws_route_table.main]
}

resource aws_route_table_association public {
  count          = length(var.availability_zones)
  route_table_id = aws_route_table.public.id
  subnet_id      = element(aws_subnet.public.*.id, count.index)
}

resource aws_route_table_association private {
  count          = length(var.availability_zones)
  route_table_id = element(aws_route_table.main.*.id, count.index)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
}
