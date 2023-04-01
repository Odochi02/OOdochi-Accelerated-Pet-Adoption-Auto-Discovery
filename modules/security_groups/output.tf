output "ansible_sg" {
  value = aws_security_group.OAPAAD_ansible_sg.id
}

output "sonarqube_sg" {
  value = aws_security_group.OAPAAD_sonarqube_sg.id
}

output "jenkins_sg" {
  value = aws_security_group.OAPAAD_jenkins_sg.id
}

output "bastion_sg" {
  value = aws_security_group.OAPAAD_bastion_sg.id
}

output "docker-prod_sg" {
  value = aws_security_group.OAPAAD_docker-prod_sg.id
}

output "docker-stage_sg" {
  value = aws_security_group.OAPAAD_docker-stage_sg.id
}

output "docker_stage_lb_sg" {
  value = aws_security_group.OAPAAD_docker_stage_lb_sg.id
}

output "docker_prod_lb_sg" {
  value = aws_security_group.OAPAAD_docker_prod_lb_sg.id
}

output "jenkins_lb_sg" {
  value = aws_security_group.OAPAAD_jenkins_lb_sg.id
}