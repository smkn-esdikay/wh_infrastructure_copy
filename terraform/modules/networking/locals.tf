locals {
  account_id        = data.aws_caller_identity.current.account_id
  max_azs           = 5
  available_azs     = length(data.aws_availability_zones.available_in_region.zone_ids)
  computed_az_count = min(local.available_azs, local.max_azs)

  global_tags = {
    Managed = "devops"
  }

  private_subnet_tags = {
    Role                                                         = "private",
    "kubernetes.io/role/internal-elb"                            = "1",
    "kubernetes.io/cluster/eks-${var.environment}-${var.region}" = "shared"
  }

  public_subnet_tags = {
    Role                                                         = "public",
    "kubernetes.io/role/elb"                                     = "1",
    "kubernetes.io/cluster/eks-${var.environment}-${var.region}" = "shared"

  }

  vpc_tags = {}

}
