output eks_cluster_open_id_connect_provider_url {
  value = aws_iam_openid_connect_provider.eks.url
}

output eks_cluster_open_id_connect_provider_arn {
  value = aws_iam_openid_connect_provider.eks.arn
}

output flux_kms_key_arn {
  value = aws_kms_key.flux.arn
}

output application_role_arns {
  value = [for attribute in local.isra_role_attributes : attribute.arn]
}

output isra_role_attributes {
  value = local.isra_role_attributes
}

output assume_role_policy {
  description = "Assume Role Policy for roles meant to be assigned to pods"
  value = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/oidc.eks.${var.region}.amazonaws.com/id/${local.eks_hash}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringLike": {
          "oidc.eks.${var.region}.amazonaws.com/id/${local.eks_hash}:sub": "system:serviceaccount:*:*"
        }
      }
    }
  ]
}
EOF
}

output endpoint {
  value = aws_eks_cluster.default.endpoint
}

output cluster_name {
  value = aws_eks_cluster.default.id
}