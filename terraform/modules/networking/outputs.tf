output vpc_id {
  value = aws_vpc.primary.id
}

output name {
  value = "${var.environment}-${var.region}"
}

output cidr_block {
  value = aws_vpc.primary.cidr_block
}

output internet_gateway_ids {
  value = aws_internet_gateway.gateway.*.id
}

output nat_gateway_ids {
  value = aws_nat_gateway.gateway.*.id
}

output region {
  value = var.region
}

output route_table_id_public {
  value = aws_route_table.public.id
}

output route_table_ids {
  value = aws_route_table.main[*].id
}

output public_subnet_ids {
  value = aws_subnet.public[*].id
}

output private_subnet_ids {
  value = aws_subnet.private[*].id
}

output availability_zones {
  value = var.availability_zones
}
