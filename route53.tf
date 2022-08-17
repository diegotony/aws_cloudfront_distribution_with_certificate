data "aws_route53_zone" "main" {
  name = var.domain
}

resource "aws_route53_record" "cname" {
    depends_on = [
    aws_acm_certificate.this
    # time_sleep.wait_600_seconds
  ]
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.subdomain
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = var.subdomain
  records        = [aws_cloudfront_distribution.this.domain_name]
}

resource "aws_route53_record" "this_validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
}