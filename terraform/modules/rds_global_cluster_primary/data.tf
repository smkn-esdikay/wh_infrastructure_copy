data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_subnet" "db_subnet" {
  id = var.db_subnet_ids[0]
}
