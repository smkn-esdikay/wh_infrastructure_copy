resource "aws_iam_policy" "core_infra_policy" {
  name        = "CoreInfraPolicy"
  description = "CoreInfra Provisioner Policy"
  policy      = data.aws_iam_policy_document.core_infra_provisioner_policy.json
}
