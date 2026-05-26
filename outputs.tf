# outputs.tf

output "name_servers" {
  description = "Nameservers da Hosted Zone Route 53 (copie esses 4 para o Registro.br)"
  value       = aws_route53_zone.thermtech.name_servers
}

output "public_ip" {
  value = aws_lightsail_static_ip.thermtech_ip.ip_address
}

output "zone_id" {
  value = aws_route53_zone.thermtech.zone_id
}
