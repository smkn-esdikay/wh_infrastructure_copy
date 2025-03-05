
resource "aws_iam_role" "node_group" {
  name               = "eks-node-group"
  assume_role_policy = data.aws_iam_policy_document.node_group.json

  inline_policy {
    name = "loki-s3"
    policy = jsonencode({
      Statement = [
        {
          Action = [
            "s3:PutObject",
            "s3:GetObject",
            "s3:ListBucket",
            "s3:DeleteObject"
          ],
          Effect   = "Allow",
          Resource = "*",
          Sid      = "VisualEditor0"
        }
      ],
      Version = "2012-10-17"
    })
  }
}
