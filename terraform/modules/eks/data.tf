# used to fetch account id
data "aws_caller_identity" "current" {}

data "external" "thumbprint" {
  program = ["${path.module}/thumbprint.sh", var.region]
}
