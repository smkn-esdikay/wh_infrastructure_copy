resource "aws_iam_role" "cert_manager" {
  name               = "cert-manager-${var.environment}-${var.region}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/oidc.eks.${var.region}.amazonaws.com/id/${local.eks_hash}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.${var.region}.amazonaws.com/id/${local.eks_hash}:sub": "system:serviceaccount:cert-manager:cert-manager"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role" "flux" {
  name               = "flux-${var.environment}-${var.region}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/oidc.eks.${var.region}.amazonaws.com/id/${local.eks_hash}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.${var.region}.amazonaws.com/id/${local.eks_hash}:sub": "system:serviceaccount:flux:flux"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role" "application" {
  name               = "${var.application_name}-${var.environment}-${var.region}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/oidc.eks.${var.region}.amazonaws.com/id/${local.eks_hash}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.${var.region}.amazonaws.com/id/${local.eks_hash}:sub": "system:serviceaccount:${var.application_name}:${var.application_name}"
        }
      }
    }
  ]
}
EOF
}

# For natural persons decrypting/encryping secrets in the github repo
resource "aws_iam_role" "flux_role" {
  # ie. FluxRoleUsEast1
  name               = "FluxRole${join("", [for i in split("-", var.region) : title(i)])}"
  assume_role_policy = data.aws_iam_policy_document.allow_assume_role.json
}

data "aws_iam_policy_document" "allow_assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "AWS"
      identifiers = [
        var.kms_key_admin_arn,
        "arn:aws:iam::${var.aws_root_account_id}:root",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
      ]
    }
  }
}
