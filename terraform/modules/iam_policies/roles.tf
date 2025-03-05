resource "aws_iam_role" "default" {
  for_each           = local.roles
  name               = each.key
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.is_assumable.json
}

locals {
  # roles flattened for consumption so every
  # combination of role-policy can be iterated over
  consumable_roles = flatten([
    for role, policyarns in local.roles : [
      for policy_arn in policyarns : {
        name       = role
        policy_arn = policy_arn
      }
    ]
  ])
}

resource "aws_iam_role_policy_attachment" "default" {
  for_each = {
    for i in local.consumable_roles : "${i.name}.${i.policy_arn}" => i
  }
  role       = each.value.name
  policy_arn = each.value.policy_arn
}
