output "ansible_IP" {
  value       = module.ansible.ansible_IP
  description = "Ansible private IP"
}

output "jenkins_public_ip" {
  value       = module.jenkins.jenkins_IP
  description = "jenkins private IP"

}

output "docker_prod_IP" {
  value       = module.docker-prod.docker_prod_IP
  description = "Docker prod private IP"
}

output "docker_stage_IP" {
  value       = module.docker-stage.docker_stage_IP
  description = "Docker stage private IP"
}

output "sonarqube_IP" {
  value       = module.sonarqube.sonarqube_IP
  description = "SonarQube public IP"
}

output "bastion_IP" {
  value       = module.bastion.Bastionhost_IP
  description = "Bastion IP"
}

output "jenkins_lb_dns" {
  value       = module.jenkins.jenkins_lb_dns
  description = "Jenkins lb name"
}

output "docker_stage_lb_dns_name" {
    value = module.docker-stage.docker_stage_lb_dns_name
}

output "docker_prod_lb_dns-name" {
  value       = module.docker-prod.docker_prod_lb_dns_name
  description = "Docker prod name"
}