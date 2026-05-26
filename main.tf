# main.tf
resource "aws_lightsail_instance" "thermtech" {
  name              = "thermtech-lightsail"
  availability_zone = "us-east-1a"
  blueprint_id      = "lamp_ls_1_0"
  bundle_id         = "micro_3_0"
  key_pair_name     = "thermtech-key"

  tags = {
    Environment = "Production"
    Name        = "Thermtech Production"
  }
}

# Static IP (altamente recomendado - evita IP mudar)
resource "aws_lightsail_static_ip" "thermtech_ip" {
  name = "thermtech-static-ip"
}

resource "aws_lightsail_static_ip_attachment" "thermtech_attachment" {
  static_ip_name = aws_lightsail_static_ip.thermtech_ip.id
  instance_name  = aws_lightsail_instance.thermtech.id
}

output "instance_name" {
  value = aws_lightsail_instance.thermtech.name
}
