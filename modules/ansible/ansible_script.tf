locals {
  ansible_user_data = <<-EOF
#!/bin/bash
sudo apt-get update -y
sudo apt install docker.io -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible -y
echo "pubkeyAcceptKeyTypes=+ssh-rsa" >> /etc/ssh/sshd_config.d/10-insecure-rsa-keysig.conf
sudo systemctl reload sshd
sudo bash -c ' echo "strictHostKeyChecking No" >> /etc/ssh/ssh_config'
echo "${var.prv_key}" >> /home/ubuntu/.ssh/OAPAAD-key
sudo chown ubuntu:ubuntu /home/ubuntu/.ssh/OAPAAD-key 
sudo chgrp ubuntu:ubuntu /home/ubuntu/.ssh/OAPAAD-key  
sudo chmod 400 /home/ubuntu/.ssh/OAPAAD-key 
sudo echo "localhost ansible_connection=local" > /etc/ansible/hosts
sudo echo "[docker-stage]" >> /etc/ansible/hosts
sudo echo "${var.docker_stage_IP} ansible_user=ec2-user ansible_ssh_private_key_file=/home/ubuntu/.ssh/OAPAAD-key" >> /etc/ansible/hosts
sudo echo "[docker-prod]" >> /etc/ansible/hosts
sudo echo "${var.docker_prod_IP} ansible_user=ec2-user ansible_ssh_private_key_file=/home/ubuntu/.ssh/OAPAAD-key" >> /etc/ansible/hosts
sudo chown -R ubuntu:ubuntu /etc/ansible
sudo touch docker_image.yml docker_prod.yml docker_stage.yml dockerfile newrelic.yml ASG-container.yml Autidoscovery.yml
echo "${file(var.docker-image)}" >> /etc/ansible/hosts/docker-image.yml
echo "${file(var.docker-stage)}" >> /etc/ansible/hosts/docker-stage.yml
echo "${file(var.docker-prod)}" >> /etc/ansible/hosts/docker-prod.yml
echo "${file(var.dockerfile)}" >> /etc/ansible/hosts/dockerfile
echo "${file(var.newrelic)}" >> /etc/ansible/hosts/newrelic.yml
echo "${file(var.ASG-container)}" >> /etc/ansible/hosts/ASG-container.yml
echo "${file(var.Autodiscovery)}" >> /etc/ansible/hosts/Autidoscovery.yml
sudo hostnamectl set-hostname Ansible
EOF
}
