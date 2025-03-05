resource "aws_ses_email_identity" "email" {
  email = "${var.subdomain}@${var.domain}"
}

resource "aws_ses_domain_identity" "domain" {
  domain = var.domain
}

resource "aws_route53_record" "amazonses_verification_record" {
  zone_id = var.route53_zone_id
  name    = "_amazonses.${aws_ses_domain_identity.domain.id}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.domain.verification_token]
}

resource "aws_ses_domain_identity_verification" "verification" {
  domain = aws_ses_domain_identity.domain.id

  depends_on = [aws_route53_record.amazonses_verification_record]
}

resource "aws_ses_domain_mail_from" "mail_from" {
  domain           = aws_ses_domain_identity.domain.domain
  mail_from_domain = "bounce.${aws_ses_domain_identity.domain.domain}"
}

resource "aws_route53_record" "mx_mail_from" {
  zone_id = var.route53_zone_id
  name    = "bounce.${aws_ses_domain_identity.domain.domain}"
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.us-east-1.amazonses.com"]

  depends_on = [aws_ses_domain_mail_from.mail_from]
}

resource "aws_route53_record" "txt_mail_from" {
  zone_id = var.route53_zone_id
  name    = "bounce.${aws_ses_domain_identity.domain.domain}"
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com ~all"]

  depends_on = [aws_ses_domain_mail_from.mail_from]
}