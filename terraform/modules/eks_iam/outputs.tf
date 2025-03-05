output eks_cluster_assume_role_arn {
  value = aws_iam_role.eks_cluster_assume_role.arn
}

output eks_node_group_role_arn {
  value = aws_iam_role.node_group.arn
}
