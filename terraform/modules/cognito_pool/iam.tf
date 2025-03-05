resource "aws_iam_role" "sns" {
  name               = var.sns_iam_role
  path               = var.sns_iam_path
  assume_role_policy = data.aws_iam_policy_document.sns_trust_relationship.json
}

resource "aws_iam_policy" "sns" {
  name   = var.sns_iam_role
  path   = var.sns_iam_path
  policy = data.aws_iam_policy_document.sns_policy.json
}

resource "aws_iam_role_policy_attachment" "sns" {
  role       = aws_iam_role.sns.name
  policy_arn = aws_iam_policy.sns.arn
}