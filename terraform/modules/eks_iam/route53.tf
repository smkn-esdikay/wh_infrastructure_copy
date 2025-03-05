resource "aws_iam_role_policy_attachment" "route53" {
  role       = aws_iam_role.node_group.name
  policy_arn = aws_iam_policy.eks_route53.arn
}

resource "aws_iam_policy" "eks_route53" {
  name        = "eks-route53"
  path        = "/"
  description = "Allows EKS Management of Route53 Entries for Service Exposure"

  policy = data.aws_iam_policy_document.route53.json
}

data "aws_iam_policy_document" "route53" {

  statement {
    actions = [
      "route53:ChangeResourceRecordSets",
    ]

    resources = [
      "arn:aws:route53:::hostedzone/*",
    ]
  }
  statement {
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
    ]

    resources = [
      "*",
    ]
  }
}
