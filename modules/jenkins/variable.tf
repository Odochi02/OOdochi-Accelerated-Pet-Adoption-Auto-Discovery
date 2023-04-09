#vpc id
variable "vpc_id" {

}

#keypair variable
variable "keypair" {
}

#security group
variable "jenkins_sg" {
}


#ami
variable "ami_redhat" {
}

#instance type
variable "instance_type" {
}


#public subnet 1 id
variable "OAPAADpubsub1_id" {
}

#public subnet 2 id
variable "OAPAADpubsub2_id" {
}

#private subnet 1 id
variable "OAPAADprvsub1_id" {
}

#prv_key
variable "prv_key" {
}

#lb security group
variable "jenkins_lb_sg" {
}

variable "jenkins-lb-name" {
    default = "jenkins-lb"
}
