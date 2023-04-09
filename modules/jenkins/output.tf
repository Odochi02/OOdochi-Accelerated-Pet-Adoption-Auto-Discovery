output "jenkins_IP" {
  value       = aws_instance.OAPAAD_jenkins.private_ip
  description = "jenkins private IP"
}

output "jenkins_lb_dns" {
  value       = aws_lb.OAPAAD-jenkins-lb.dns_name
  description = "Docker prod public IP"
}
