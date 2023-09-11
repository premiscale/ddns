data "aws_route53_zone" "domain" {
  name         = var.domain
  private_zone = false
}

resource "aws_route53_record" "chelsea" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = var.domain_record
  type    = "A"
  ttl     = "3600"
  records = [var.ip]
}