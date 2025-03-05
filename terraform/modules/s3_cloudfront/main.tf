resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled = true

  aliases = [var.s3_cdn_distribution_domain]

  comment = var.comment

  is_ipv6_enabled = true

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    compress         = true
    target_origin_id = "S3-${var.origin_bucket_id}"

    forwarded_values {
      query_string = true
      query_string_cache_keys = [
        "X-Amz-SignedHeaders",
      ]

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "https-only"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  origin {
    domain_name = var.bucket_regional_domain_name
    origin_id   = "S3-${var.origin_bucket_id}"
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    minimum_protocol_version = "TLSv1.1_2016"
    ssl_support_method       = "sni-only"
  }
}
