output "docker_prod_IP" {
  value       = aws_instance.docker_prod.private_ip
  description = "Docker prod public IP"
}

output "docker_prod_lb_dns_name" {
  value       = aws_lb.docker-prod-lb.dns_name
  description = "Docker prod public IP"
}

output "docker_prod_lb_zone_id" {
  value       = aws_lb.docker-prod-lb.zone_id
  description = "Docker prod zone id"
}

output "docker_prod_target_group_arn" {
  value       = aws_lb_target_group.docker-prod-tg.arn
  description = "Docker prod target group arn"
}

output "docker_prod_data_instance_id" {
  value       = data.aws_instance.docker_prod.id
  description = "Docker prod data instance id"
}

output "docker_prod_instance" {
  value = aws_instance.docker_prod
  description = "Docker prod instance"
}