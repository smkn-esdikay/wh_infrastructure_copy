resource "aws_iam_policy" "cert_manager" {
  name        = "cert-manager-${var.region}"
  path        = "/"
  description = "Allows CertManager to manage dns records"

  policy = data.aws_iam_policy_document.cert_manager.json
}

resource "aws_iam_policy" "flux_policy" {
  name        = "FluxPolicy${join("", [for i in split("-", var.region) : title(i)])}"
  description = "Flux Policy"
  policy      = data.aws_iam_policy_document.flux_policy.json
}

resource "aws_iam_policy" "ecr_policy" {
  name        = "ECRPolicy${join("", [for i in split("-", var.region) : title(i)])}"
  description = "ECR Pull Policy"
  policy      = data.aws_iam_policy_document.ecr_policy.json
}
