resource "aws_iam_role_policy_attachment" "attach_flux_policy_to_role" {
  role       = aws_iam_role.flux_role.name
  policy_arn = aws_iam_policy.flux_policy.arn
}

resource "aws_iam_role_policy_attachment" "attach_cert_manager_policy_to_role" {
  role       = aws_iam_role.cert_manager.name
  policy_arn = aws_iam_policy.cert_manager.arn
}

resource "aws_iam_role_policy_attachment" "attach_ecr_policy_to_role" {
  role       = aws_iam_role.application.name
  policy_arn = aws_iam_policy.ecr_policy.arn
}
