
resource "aws_iam_role_policy_attachment" "ebs-csi" {
  role       = aws_iam_role.node_group.name
  policy_arn = aws_iam_policy.ebs_csi.arn
}

resource "aws_iam_role_policy_attachment" "loadbalancer-controller" {
  role       = aws_iam_role.node_group.name
  policy_arn = aws_iam_policy.loadbalancer_controller.arn
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "loki_s3" {
  role       = aws_iam_role.node_group.name
  policy_arn = aws_iam_policy.loki_s3.arn
}
