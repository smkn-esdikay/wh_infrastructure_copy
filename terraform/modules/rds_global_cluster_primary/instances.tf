resource "aws_rds_cluster_instance" "cluster_instances" {
  count = var.cluster_size

  identifier            = "${local.cluster_identifier}-${count.index}"
  cluster_identifier    = aws_rds_cluster.primary.id
  instance_class        = var.instance_class
  engine                = aws_rds_cluster.primary.engine
  engine_version        = aws_rds_cluster.primary.engine_version
  db_subnet_group_name  = aws_db_subnet_group.default.name
  copy_tags_to_snapshot = true
  tags                  = local.global_tags

  # Ignore arguments without API methods for reading information after creation.
  lifecycle {
    ignore_changes = [cluster_identifier]
  }
}
