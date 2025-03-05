resource "aws_iam_policy" "eks_list" {
  name        = "EKSList"
  description = "List EKS Clusters"
  policy      = data.aws_iam_policy_document.eks_list.json
}

resource "aws_iam_policy" "assume_group_roles" {
  name        = "AssumeGroupsRoles"
  description = "Allows user to assueme their group's role(s)"
  policy      = data.aws_iam_policy_document.allow_assuming_groups_roles.json
}

resource "aws_iam_policy_attachment" "assume_group_roles" {
  name       = "allow-assumption-of-groups-roles"
  users      = keys(var.users)
  policy_arn = aws_iam_policy.assume_group_roles.arn
}

resource "aws_iam_policy" "sops_write" {
  name        = "SopsWrite"
  description = "SOPS Write"
  policy      = data.aws_iam_policy_document.sops_write.json
}
resource "aws_iam_policy" "sops_read" {
  name        = "SopsRead"
  description = "SOPS Read"
  policy      = data.aws_iam_policy_document.sops_read.json
}

resource "aws_iam_policy" "s3_write" {
  name        = "S3Write"
  description = "S3 Write"
  policy      = data.aws_iam_policy_document.s3_read.json
}
resource "aws_iam_policy" "s3_read" {
  name        = "S3Read"
  description = "S3 Read"
  policy      = data.aws_iam_policy_document.s3_write.json
}
