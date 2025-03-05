locals {
  region             = data.aws_region.current.name
  cluster_identifier = "${var.global_cluster_identifier}-${local.region}"

  global_tags = {
    Managed = "dev-ops"
  }
}
