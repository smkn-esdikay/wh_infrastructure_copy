resource "aws_iam_service_linked_role" "rds" {
  aws_service_name = "rds.amazonaws.com"
}
