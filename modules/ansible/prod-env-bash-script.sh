locals {
  ansible_user_data = <<-EOF

#!/bin/bash
# This script automatically update ansible host inventory
#TAG='ASG-test'
AWSBIN='/usr/local/bin/aws'
awsDiscovery() {
	\$AWSBIN ec2 describe-instances --filters Name=tag:aws:autoscaling:groupName,Values=OAPAAD_ASG \
		--query Reservations[*].Instances[*].NetworkInterfaces[*].{PrivateIpAddresses:PrivateIpAddress} > /etc/ansible/stage-ips.list
	}
inventoryUpdate() {
	echo > /etc/ansible/hosts 
  	echo [webservers] > /etc/ansible/stage-hosts
	for instance in `cat /etc/ansible/stage-ips.list`
	do
		ssh-keyscan -H \$instance >> ~/.ssh/known_hosts
echo "
\$instance ansible_user=ec2-user ansible_ssh_private_key_file=/etc/ansible/key.pem
" >> /etc/ansible/stage-hosts
       done
}
instanceUpdate() {
  sleep 30
  ansible-playbook -i ~/ansible-files/stage-hosts stage-env-playbook.yml
  sleep 30
}
awsDiscovery
inventoryUpdate
#instanceUpdate
sudo hostnamectl set-hostname docker-Stage
sudo reboot
sudo hostnamectl set-hostname Jenkins
sudo reboot
EOF

