# VPC CIDR 
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Public Subnet 1 CIDR
variable "OAPAADpubsub1_cidr" {
  default = "10.0.1.0/24"
}

# Public Subnet 2 CIDR
variable "OAPAADpubsub2_cidr" {
  default = "10.0.2.0/24"
}

# Private Subnet 1 CIDR
variable "OAPAADprvsub1_cidr" {
  default = "10.0.3.0/24"
}

# Private Subnet 2 CIDR
variable "OAPAADprvsub2_cidr" {
  default = "10.0.4.0/24"
}

#All IP CIDR
variable "all_ip" {
  default = "0.0.0.0/0"
}

#ssh port
variable "ssh_port" {
  default = 22
}

#Sonarqube port
variable "sonarqube_port" {
    default = 9000

}


# Jenkins port
variable "jenkins_port" {
    default = 8080

}

# http port
variable "http_port" {
  default = 80

}

# MySql Port
variable "mysql_port" {
  default = "3306"
}

# Jenkins proxy port
variable "proxy_port" {
    default = 8080

}

# keypair variable
variable "keypair" {
  default = ""
}

#security group
variable "ansible_sg" {
  default = ""
}

variable "sonarqube_sg" {
  default = ""
}

variable "docker-stage_sg" {
  default = ""
}

variable "docker-prod_sg" {
  default = ""
}

variable "bastion_sg" {
  default = ""
}

variable "jenkins_sg" {
  default = ""
}

variable "jenkins_lb_sg" {
  default = ""
}

#ami
variable "ami_redhat" {
  default = "ami-05c96317a6278cfaa"
}

#ami
variable "ami_ubuntu" {
  default = "ami-0fdf70ed5c34c5f52"
}

#instance type
variable "instance_type" {
  default = "t2.medium"

}

#vpc id
variable "vpc_id" {
  default = ""
}

#public subnet 1 id
variable "OAPAADpubsub1_id" {
  default = ""
}

#public subnet 2 id
variable "OAPAADpubsub2_id" {
  default = ""
}

#public subnet id
variable "OAPAADprvsub1_id" {
  default = ""
}
