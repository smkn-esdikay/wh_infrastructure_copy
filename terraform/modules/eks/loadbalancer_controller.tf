module "alb_controller" {
  source                           = "../helm/loadbalancer_controller"
  cluster_name                     = local.cluster_name
  cluster_identity_oidc_issuer     = aws_eks_cluster.default.identity[0].oidc[0].issuer
  cluster_identity_oidc_issuer_arn = aws_iam_openid_connect_provider.eks.arn
  aws_region                       = var.region
}