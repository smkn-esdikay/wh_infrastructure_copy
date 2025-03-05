variable users {}
variable sops_keys {
  description = "Key arns for which pintvRW users have encrypt/decrypt access"
  default = ["*"]
}

variable s3_buckets {
  description = "pintv S3 storage buckets for which pintvRW users have read/write access"
  default = ["*"]
}
