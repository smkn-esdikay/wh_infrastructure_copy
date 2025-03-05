resource aws_nat_gateway gateway {
  count         = length(var.availability_zones)
  allocation_id = element(aws_eip.nat_gateway.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  tags = merge(
    tomap({"Name" = "${var.environment}_${element(var.availability_zones, count.index)}"}),
    local.global_tags
  )

  depends_on = [aws_eip.nat_gateway, aws_subnet.public]
}

resource aws_eip nat_gateway {
  count = length(var.availability_zones)
  vpc   = true
}
