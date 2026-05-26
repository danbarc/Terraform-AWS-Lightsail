# route53.tf

# Hosted Zone
resource "aws_route53_zone" "thermtech" {
  name = "thermtech.com.br"
  tags = {
    Environment = "Production"
    Name        = "Thermtech Production"
  }
}

# Principal

# A - Domínio principal
resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "thermtech.com.br"
  type    = "A"
  ttl     = 3600
  records = ["3.214.67.156"]
}

# A - Portal
resource "aws_route53_record" "portal" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "portal.thermtech.com.br"
  type    = "A"
  ttl     = 3600
  records = ["3.214.67.156"]
}

# CNAME www
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "www"
  type    = "CNAME"
  ttl     = 3600
  records = ["thermtech.com.br"]
}

# Microsoft 365 

resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "thermtech.com.br"
  type    = "MX"
  ttl     = 3600
  records = ["0 thermtech-com-br.mail.protection.outlook.com."]
}

resource "aws_route53_record" "spf" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "thermtech.com.br"
  type    = "TXT"
  ttl     = 3600
  records = ["v=spf1 include:spf.protection.outlook.com include:amazonses.com include:spf.emailsignatures365.com -all"]
}

resource "aws_route53_record" "dmarc" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=quarantine; pct=100; rua=mailto:dmarc@thermtech.com.br; fo=1;"]
}

# DKIM Microsoft (selector1 e selector2)
resource "aws_route53_record" "dkim_selector1" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "selector1._domainkey"
  type    = "CNAME"
  ttl     = 43200
  records = ["selector1-thermtech-com-br._domainkey.tht360.onmicrosoft.com"]
}

resource "aws_route53_record" "dkim_selector2" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "selector2._domainkey"
  type    = "CNAME"
  ttl     = 43200
  records = ["selector2-thermtech-com-br._domainkey.tht360.onmicrosoft.com"]
}

# Autodiscover, SIP, Lync, etc.
resource "aws_route53_record" "autodiscover" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "autodiscover"
  type    = "CNAME"
  ttl     = 43200
  records = ["autodiscover.outlook.com"]
}

resource "aws_route53_record" "sip" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "sip"
  type    = "CNAME"
  ttl     = 43200
  records = ["sipdir.online.lync.com"]
}

resource "aws_route53_record" "lyncdiscover" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "lyncdiscover"
  type    = "CNAME"
  ttl     = 43200
  records = ["webdir.online.lync.com"]
}

resource "aws_route53_record" "sipfederationtls" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "_sipfederationtls._tcp"
  type    = "SRV"
  ttl     = 3600
  records = ["100 1 5061 sipfed.online.lync.com."]
}

resource "aws_route53_record" "siptls" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "_sip._tls"
  type    = "SRV"
  ttl     = 3600
  records = ["100 1 443 sipdir.online.lync.com."]
}

# Enterprise Registration / Enrollment
resource "aws_route53_record" "enterpriseregistration" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "enterpriseregistration"
  type    = "CNAME"
  ttl     = 43200
  records = ["enterpriseregistration.windows.net"]
}

resource "aws_route53_record" "enterpriseenrollment" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "enterpriseenrollment"
  type    = "CNAME"
  ttl     = 43200
  records = ["enterpriseenrollment.manage.microsoft.com"]
}

# Custom MAIL FROM
resource "aws_route53_record" "ses_mail_from_mx" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "mail.thermtech.com.br"
  type    = "MX"
  ttl     = 3600
  records = ["10 feedback-smtp.us-east-1.amazonses.com"]
}

resource "aws_route53_record" "ses_mail_from_spf" {
  zone_id = aws_route53_zone.thermtech.zone_id
  name    = "mail.thermtech.com.br"
  type    = "TXT"
  ttl     = 3600
  records = ["v=spf1 include:amazonses.com -all"]
}
