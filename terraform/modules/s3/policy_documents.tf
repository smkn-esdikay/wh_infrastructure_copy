data aws_iam_policy_document s3_rw {
  statement {
    actions = ["s3:ListBucket"]
    effect  = "Allow"
    resources = [
      aws_s3_bucket.primary_store.arn
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObjectAcl"
    ]
    resources = [
      "${aws_s3_bucket.primary_store.arn}/*"
    ]
  }

  statement {
    actions = ["kms:*"]
    effect  = "Allow"
    resources = [
      aws_kms_key.primary_store.arn
    ]
  }
}
