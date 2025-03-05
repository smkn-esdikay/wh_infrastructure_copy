resource "aws_iam_user" "default" {
  for_each = var.users
  name     = each.key
  path     = "/"
}
