#vpc id
variable "vpc_id" {

}

#keypair variable
variable "keypair" {
}

#security group
variable "ansible_sg" {
}


#ami
variable "ami_ubuntu" {
}

#instance type
variable "instance_type" {
}


#private subnet id
variable "OAPAADprvsub1_id" {
}

#prv_key
variable "prv_key" {
}

#docker_stage_IP
variable "docker_stage_IP" {
}

#docker_prod_IP
variable "docker_prod_IP" {
}


#Ansible Playbook.yaml path
/*variable "ansible_playbook_path" {
  default = "MyPlaybook.yaml"
}*/

#docker_image.yml
variable "docker-image" {
}

#docker_prod.yml
variable "docker-prod" {
}

#docker_stage.yml
variable "docker-stage" {
}

#newrelic.yml
variable "newrelic" {
}

#dockerfile.yml
variable "dockerfile" {
}

#ASG-container.yml
variable "ASG-container" {
}

#Autodiscovery.yml
variable "Autodiscovery" {
}

variable "aws_instace_profile" {

}