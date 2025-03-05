output "core_infra_role_arn" {
  value = aws_iam_role.core_infra_role.arn
}

output "autoscaling_service_role_arn" {
  value = aws_iam_service_linked_role.autoscsaling.arn
}

output "core_infra_policy_document" {
  value = aws_iam_policy.core_infra_policy.policy
}
