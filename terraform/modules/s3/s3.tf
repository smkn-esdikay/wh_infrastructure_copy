resource "aws_s3_bucket" "primary_store" {
  bucket_prefix = "pintv-store-${var.environment}-"
  acl           = "private"

  # NOTE: Clear partial or aborted uploads (in the cache):
  lifecycle_rule {
    abort_incomplete_multipart_upload_days = 7
    enabled                                = true
    id                                     = "Clear Cache"
    prefix                                 = "cache"
    tags                                   = {}

    expiration {
      days                         = 30
      expired_object_delete_marker = false
    }

    noncurrent_version_expiration {
      days = 30
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.primary_store.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  depends_on = [aws_kms_key.primary_store]
}

resource "aws_s3_bucket_public_access_block" "primary_store" {
  bucket                  = aws_s3_bucket.primary_store.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
