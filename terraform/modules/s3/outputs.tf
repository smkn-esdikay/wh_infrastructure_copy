output primary_store_id {
  value = aws_s3_bucket.primary_store.id
}

output primary_store_regional_domain_name {
  value = aws_s3_bucket.primary_store.bucket_regional_domain_name
}

output s3_user_arn {
  value = aws_iam_user.s3.arn
}

output s3_role_arn {
  value = aws_iam_role.s3.arn
}

output s3_policy_arn {
  value = aws_iam_policy.s3_rw.arn
}

output aws_iam_access_key {
  value = aws_iam_access_key.s3
}
