resource "aws_s3_bucket" "static_files" {
  bucket = "${var.project}-${var.environment}-app-static-files"
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.static_files.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.static_files.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.static_files.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.static_files.bucket

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:GetObject"
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.static_files.arn}/public/*"
        Principal = "*"
      },
      {
        Action    = "s3:GetObject"
        Sid       = "PublicReadGetObject"
        Effect    = "Deny"
        Resource  = "${aws_s3_bucket.static_files.arn}/private/*"
        Principal = "*"
      }
    ]
  })
}
