output "sonarqube_IP" {
  value       = aws_instance.OAPAAD_sonarqube.public_ip
  description = "sonarqube public IP"
}

