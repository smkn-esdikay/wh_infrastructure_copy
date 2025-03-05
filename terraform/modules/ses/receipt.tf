resource "aws_ses_receipt_rule" "store" {
  name          = "${var.project}-store"
  rule_set_name = aws_ses_receipt_rule_set.main.id
  enabled       = true
  scan_enabled  = true

  s3_action {
    bucket_name = aws_s3_bucket.store.id
    object_key_prefix = "mailbox/${var.subdomain}@${var.domain}"
    position = 1
  }
}

resource "aws_ses_receipt_rule_set" "main" {
  rule_set_name = "${var.project}-${var.environment}-ruleset"
}