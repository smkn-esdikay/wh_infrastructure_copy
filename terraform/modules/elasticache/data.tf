data "aws_region" "current" {}

data "aws_subnet" "cache_subnet" {
  id = var.cache_subnet_ids[0]
}
