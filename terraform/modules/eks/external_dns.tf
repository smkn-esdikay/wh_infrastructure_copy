module "eks-external-dns" {
    source  = "lablabs/eks-external-dns/aws"
    version = "0.9.0"
    cluster_identity_oidc_issuer =  aws_eks_cluster.default.identity[0].oidc[0].issuer
    cluster_identity_oidc_issuer_arn = aws_iam_openid_connect_provider.eks.arn
    helm_chart_version = "7.2.0"
    policy_allowed_zone_ids = [
        var.hosted_zone_id  # zone id of your hosted zone
    ]
    settings = {
      "policy" = "sync" # syncs DNS records with ingress and services currently on the cluster.
    }
}