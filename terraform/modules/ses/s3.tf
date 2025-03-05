data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "store" {
  bucket = "store-${var.subdomain}-${var.domain}"
  
  server_side_encryption_configuration {
    rule {
      bucket_key_enabled = false
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "${var.subdomain}-${var.domain}"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_receipt" {
  bucket = aws_s3_bucket.store.id
  policy = <<POLICY
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "AllowSESPuts",
              "Effect": "Allow",
              "Principal": {
                  "Service": "ses.amazonaws.com"
              },
              "Action": "s3:PutObject",
              "Resource": "arn:aws:s3:::${aws_s3_bucket.store.id}/*",
              "Condition": {
                  "StringEquals": {
                      "AWS:SourceArn": "arn:aws:ses:${var.region}:${data.aws_caller_identity.current.account_id}:receipt-rule-set/${aws_ses_receipt_rule_set.main.id}:receipt-rule/${aws_ses_receipt_rule.store.name}",
                      "AWS:SourceAccount": "${data.aws_caller_identity.current.account_id}"
                  }
              }
          }
      ]
  }
  POLICY
}
