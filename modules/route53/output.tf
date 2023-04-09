output "acm_cert_arn" {
  value = aws_acm_certificate.OAPAADcert.arn
}

output "name_servers" {
  value = data.aws_route53_zone.OAPAADroute53_zone.name_servers
}