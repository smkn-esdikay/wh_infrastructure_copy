locals {
  region                    = data.aws_region.current.name
  global_cluster_identifier = var.environment
  cluster_identifier        = "${local.global_cluster_identifier}-${local.region}"

  global_tags = {
    Managed = "dev-ops"
  }
}
