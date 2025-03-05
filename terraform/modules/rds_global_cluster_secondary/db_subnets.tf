resource "aws_db_subnet_group" "default" {
  name       = local.cluster_identifier
  subnet_ids = var.db_subnet_ids

  tags = local.global_tags
}
