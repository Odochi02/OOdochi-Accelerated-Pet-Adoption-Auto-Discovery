module "vpc" {
  source   = "../../modules/VPC"
  vpc_cidr = var.vpc_cidr

}

module "subnets" {
  source   = "../../modules/subnets"
  OAPAADpubsub1_cidr = var.OAPAADpubsub1_cidr
  OAPAADpubsub2_cidr = var.OAPAADpubsub2_cidr
  OAPAADprvsub1_cidr = var.OAPAADprvsub1_cidr
  OAPAADprvsub2_cidr = var.OAPAADprvsub2_cidr
  all_ip             = var.all_ip
  vpc_id   = module.vpc.vpc_id
  
}

module "security_groups" {
  source   = "../../modules/security_groups"
  ssh_port = var.ssh_port
  sonarqube_port = var.sonarqube_port
  jenkins_port = var.jenkins_port
  all_ip             = var.all_ip
  vpc_id   = module.vpc.vpc_id
 
}

module "keypair" {
  source = "../../modules/keypair"
}