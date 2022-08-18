# resource "time_sleep" "wait_600_seconds" {
#   create_duration = "600s"
# }

resource "aws_acm_certificate" "this" { 
  domain_name       = "${var.subdomain}.${var.domain}"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "this_validation" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.this_validation : record.fqdn]
}
