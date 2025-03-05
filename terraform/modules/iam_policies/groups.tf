resource "aws_iam_group" "default" {
  for_each = local.groups
  name     = each.key
  path     = "/"
}

resource "aws_iam_group" "mfa_self_manage" {
  name = "SelfManageMFA"
  path = "/"
}

resource "aws_iam_group_membership" "mfa_self_manage" {
  name  = "SelfManageMFA-group-membership"
  users = [for k, v in var.users : k]
  group = "SelfManageMFA"
}

resource "aws_iam_group_policy_attachment" "mfa-self-manage-attach" {
  group      = aws_iam_group.mfa_self_manage.name
  policy_arn = aws_iam_policy.self_managa_mfa.arn
}

resource "aws_iam_group_membership" "default" {
  for_each = local.groups
  name     = "${each.key}-group-membership"
  users    = [for username, usergroups in var.users : username if contains(usergroups, each.key)]
  group    = each.key
}

locals {
  # groups flattened for consumption so every
  # combination of group-policy can be iterated over
  consumable_groups = flatten([
    for group, roles in local.groups : [
      for role in roles : {
        name = group
        role = role
      }
    ]
  ])
}

resource "aws_iam_group_policy" "default" {
  for_each = {
    for i in local.consumable_groups : "${i.name}.${i.role}" => i
  }
  group  = each.value.name
  name   = each.key
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Effect": "Allow",
      "Resource": [
                "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${each.value.role}"
            ]
    }
  ]
}
EOF
}
