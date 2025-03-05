resource "aws_ecr_repository" main {
  for_each             = toset(var.repos)
  name                 = each.value
  image_tag_mutability = "IMMUTABLE"
}

resource aws_ecr_repository_policy allow_subaccounts {
  for_each   = aws_ecr_repository.main
  repository = each.value.name
  policy     = data.aws_iam_policy_document.allow_accounts_ecr_pull.json
}

data "aws_iam_policy_document" "allow_accounts_ecr_pull" {
  statement {
    sid = "AllowPull"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
    ]
    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", var.account_ids)
    }
  }

}

resource "aws_ecr_lifecycle_policy" "default" {
  for_each   = aws_ecr_repository.main
  repository = each.value.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire older images when the total image count exceeds 30 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
