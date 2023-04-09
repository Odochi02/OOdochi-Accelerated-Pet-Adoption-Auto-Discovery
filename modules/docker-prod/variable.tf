#vpc id
variable "vpc_id" {

}

#keypair variable
variable "keypair" {
}

#security group
variable "docker-prod_sg" {
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


#private subnet 2 id
variable "OAPAADprvsub2_id" {
}

#prv_key
variable "prv_key" {
}

#security group
variable "docker_prod_lb_sg" {
}

variable "docker-prod-lb-name" {
    default = "docker-prod-lb"
}

