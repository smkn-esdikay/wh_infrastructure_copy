output distribution_domain_name {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

output distribution_id {
  value = aws_cloudfront_distribution.s3_distribution.id
}
