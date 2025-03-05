resource "aws_iam_role_policy_attachment" "attach_core_infra_policy_to_role" {
  role       = aws_iam_role.core_infra_role.name
  policy_arn = aws_iam_policy.core_infra_policy.arn
}
