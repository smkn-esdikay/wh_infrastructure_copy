resource "aws_iam_role" "core_infra_role" {
  name               = "CoreInfraRole"
  assume_role_policy = data.aws_iam_policy_document.allow_root_assume_role.json
}

data "aws_iam_policy_document" "allow_root_assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.aws_root_account_id}:root",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/Administrator",
        "arn:aws:iam::${var.aws_root_account_id}:role/Administrator"
      ]
    }
  }
}

resource "aws_iam_service_linked_role" "autoscsaling" {
  aws_service_name = "autoscaling.amazonaws.com"
}
