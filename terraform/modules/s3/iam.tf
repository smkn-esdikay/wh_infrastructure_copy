resource "aws_iam_user" "s3" {
  name = "pintv-store-machine-${var.environment}"
  path = "/"
}

resource "aws_iam_role" "s3" {
  name = "pintv-store-machine-${var.environment}"
  path = "/"
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_policy" "s3_rw" {
  name        = "pintvMachineS3RW"
  description = "Allows user (machine/server) read/write permission on s3 buckets"
  policy      = data.aws_iam_policy_document.s3_rw.json
}

resource "aws_iam_role_policy_attachment" "s3_rw" {
  role       = aws_iam_role.s3.name
  policy_arn = aws_iam_policy.s3_rw.arn
}

resource "aws_iam_policy_attachment" "s3_rw" {
  name       = "pintv-machine-s3-rw"
  users      = [aws_iam_user.s3.name]
  policy_arn = aws_iam_policy.s3_rw.arn
}

resource "aws_iam_access_key" "s3" {
  user = aws_iam_user.s3.name
}
