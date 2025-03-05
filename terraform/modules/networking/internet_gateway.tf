resource aws_internet_gateway gateway {
  tags = merge(
    tomap({"Name" = var.environment}),
    tomap({"Environment" = var.environment}),
    local.global_tags,
  )

  vpc_id = aws_vpc.primary.id

}
