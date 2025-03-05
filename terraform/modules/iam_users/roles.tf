resource "aws_iam_role" "default" {
  for_each           = toset(local.roles)
  name               = each.key
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy[each.key].json
}

data "aws_iam_policy_document" "assume_role_policy" {
  for_each = toset(local.roles)
  depends_on = [aws_iam_user.default]
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "AWS"
      identifiers = concat(
        [ for user in local.roles_to_authorized_users[each.key] : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${user}" ],
        [ for user in local.roles_to_authorized_users[each.key] : "arn:aws:iam::${var.aws_root_account_id}:user/${user}" ],
        [ "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" ]
      )
    }
  }
}
