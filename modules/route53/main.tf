/*# Create Route 53
resource "aws_route53_zone" "OAPAAD_route53" {
  name =  "odoo.lol"
  tags = {
    Environment = "OAPAAD_route53"
  }
}
resource "aws_route53_record" "OAPAAD_a_record" {
  zone_id = aws_route53_zone.OAPAAD_route53.zone_id
  name    =  "odoo.lol"
  type    = "A"
  alias {
    name                   = aws_lb.OAPAAD-lb.dns_name
    zone_id                = aws_lb.OAPAAD-lb.zone_id
    evaluate_target_health = false
  }
}*/


#certificate
resource "aws_acm_certificate" "OAPAADcert" {
  domain_name       = "odoo.lol"
  validation_method = "DNS"

  tags = {
    Environment = "OAPAADcert"
  }

  lifecycle {
    create_before_destroy = true
  }
}


# get details about a route 53 hosted zone
data "aws_route53_zone" "OAPAADroute53_zone" {
  name         =  "odoo.lol"
  private_zone = false
}

# create a record set in route 53 for domain validatation
resource "aws_route53_record" "OAPAAD_record" {
  for_each = {
    for dvo in aws_acm_certificate.OAPAADcert.domain_validation_options : dvo.domain_name => {
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
  zone_id         = data.aws_route53_zone.OAPAADroute53_zone.zone_id
}

# validate acm certificates
resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  certificate_arn         = aws_acm_certificate.OAPAADcert.arn
  validation_record_fqdns = [for record in aws_route53_record.OAPAAD_record : record.fqdn]
}

resource "aws_route53_record" "OAPAAD_a_record" {
  zone_id = data.aws_route53_zone.OAPAADroute53_zone.zone_id
  name    = "odoo.lol"
  type    = "A"

  alias {
    name                   = var.lb_name
    zone_id                = var.zone_id
    evaluate_target_health = true
  }
}


