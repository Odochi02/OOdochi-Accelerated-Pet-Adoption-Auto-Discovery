output "Bastionhost_IP" {
  value       = aws_instance.Bastion_host.public_ip
  description = "Bastion host IP"
}