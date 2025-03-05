resource "aws_s3_bucket" "loki_s3" {
  bucket = "pintv-dev-loki-backend"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    name        = "pintv-dev-loki-backend"
    environment = "development"
  }
}

resource "aws_s3_bucket_public_access_block" "block-public-access" {
  bucket = aws_s3_bucket.loki_s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

data "aws_caller_identity" "current" {}
# Creating an S3 Bucket Policy for Controlled Access
resource "aws_s3_bucket_policy" "loki_s3_policy" {
  bucket = aws_s3_bucket.loki_s3.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.loki_s3.arn}/*"
      },
      {
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/OrganizationAccountAccessRole" 
        },
        Action = "s3:*",
        Resource = "${aws_s3_bucket.loki_s3.arn}/*"
      }
    ]
  })
}