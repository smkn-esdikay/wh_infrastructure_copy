resource aws_subnet public {
  availability_zone = element(data.aws_availability_zones.available_in_region.names, count.index)
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 6, 0 + count.index)
  count             = length(var.availability_zones)

  tags = merge(
    tomap({"Name" = "public_${element(var.availability_zones, count.index)}"}),
    local.global_tags,
    local.public_subnet_tags,
  )

  vpc_id = aws_vpc.primary.id

  lifecycle {
    ignore_changes = [
      # eks managed
      tags,
    ]
  }

}

resource aws_subnet private {
  count             = length(var.availability_zones)
  availability_zone = element(var.availability_zones, count.index)
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 6, 5 + count.index)

  tags = merge(
    tomap({"Name" = "private_${element(var.availability_zones, count.index)}"}),
    local.global_tags,
    local.private_subnet_tags,
  )

  vpc_id = aws_vpc.primary.id

  lifecycle {
    ignore_changes = [
      # eks managed
      tags,
    ]
  }
}
