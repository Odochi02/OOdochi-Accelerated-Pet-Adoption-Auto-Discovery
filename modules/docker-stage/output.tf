output "docker_stage_IP" {
  value       = aws_instance.docker_stage.private_ip
  description = "Docker Stage public IP"
}


output "docker_stage_lb_dns_name" {
  value = aws_lb.docker-stage-lb.dns_name
}

