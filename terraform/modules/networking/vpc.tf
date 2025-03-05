resource aws_vpc primary {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = merge(
    tomap({"Name" = var.environment}),
    tomap({"Environment" = var.environment}),
    local.global_tags,
  )
}
