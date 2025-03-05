data "aws_region" "current" {}

data "aws_subnet" "db_subnet" {
  id = var.db_subnet_ids[0]
}
