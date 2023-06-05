output "fqdn" {
  value = aws_route53_record.chelsea.fqdn
}

output "name" {
  value = aws_route53_record.chelsea.name
}

output "zone_id" {
  value = data.aws_route53_zone.domain.zone_id
}