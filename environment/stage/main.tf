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
  http_port = var.http_port
  sonarqube_port = var.sonarqube_port
  jenkins_port = var.jenkins_port
  proxy_port = var.proxy_port
  all_ip             = var.all_ip
  vpc_id   = module.vpc.vpc_id
 
}

module "keypair" {
  source = "../../modules/keypair"
}

module "ansible" {
  source           = "../../modules/ansible"
  keypair          = module.keypair.OAPAAD_pub_key
  ami_ubuntu             = var.ami_ubuntu
  instance_type    = var.instance_type
  ansible_sg       = module.security_groups.ansible_sg
  vpc_id   = module.vpc.vpc_id
  OAPAADprvsub1_id = module.subnets.prvsub_1
  prv_key          = module.keypair.prv_key
  newrelic = "../../modules/ansible/newrelic.yml"
  dockerfile = "../../modules/ansible/dockerfile"
  docker-image = "../../modules/ansible/docker-image.yml"
  docker-prod = "../../modules/ansible/docker-prod.yml"
  docker-stage = "../../modules/ansible/docker-stage.yml"
  ASG-container = "../../modules/ansible/ASG-container.yml"
  Autodiscovery = "../../modules/ansible/Autodiscovery.yml"
  docker_prod_IP = module.docker-prod.docker_prod_IP
  docker_stage_IP = module.docker-stage.docker_stage_IP
  aws_instace_profile = module.ansible.aws_instance_profile_id  
}

module "jenkins" {
  source           = "../../modules/jenkins"
  keypair          = module.keypair.OAPAAD_pub_key
  prv_key          = module.keypair.prv_key
  ami_redhat              = var.ami_redhat
  instance_type    = var.instance_type
  jenkins_sg       = module.security_groups.jenkins_sg
  jenkins_lb_sg = module.security_groups.jenkins_lb_sg
  OAPAADpubsub1_id = module.subnets.pubsub_1
  OAPAADpubsub2_id = module.subnets.pubsub_2
  OAPAADprvsub1_id = module.subnets.prvsub_1
  vpc_id   = module.vpc.vpc_id
}

module "docker-prod" {
  source           = "../../modules/docker-prod"
  keypair          = module.keypair.OAPAAD_pub_key
  prv_key          = module.keypair.prv_key
  ami_redhat              = var.ami_redhat
  instance_type    = var.instance_type
  docker-prod_sg       = module.security_groups.docker-prod_sg
  docker_prod_lb_sg       = module.security_groups.docker_prod_lb_sg
  OAPAADpubsub1_id = module.subnets.pubsub_1
  OAPAADpubsub2_id = module.subnets.pubsub_2
  OAPAADprvsub1_id = module.subnets.prvsub_1
  OAPAADprvsub2_id = module.subnets.prvsub_2
  vpc_id   = module.vpc.vpc_id
}

module "docker-stage" {
  source           = "../../modules/docker-stage"
  keypair          = module.keypair.OAPAAD_pub_key
  prv_key          = module.keypair.prv_key
  ami_redhat              = var.ami_redhat
  instance_type    = var.instance_type
  docker-stage_sg       = module.security_groups.docker-stage_sg
  docker_stage_lb_sg       = module.security_groups.docker_stage_lb_sg
  OAPAADpubsub1_id = module.subnets.pubsub_1
  OAPAADpubsub2_id = module.subnets.pubsub_2
  OAPAADprvsub1_id = module.subnets.prvsub_1
  vpc_id   = module.vpc.vpc_id
}

module "sonarqube" {
  source           = "../../modules/sonarqube"
  keypair          = module.keypair.OAPAAD_pub_key
  prv_key          = module.keypair.prv_key
  ami_ubuntu             = var.ami_ubuntu
  instance_type    = var.instance_type
  sonarqube_sg       = module.security_groups.sonarqube_sg
  OAPAADpubsub1_id = module.subnets.pubsub_1
  vpc_id   = module.vpc.vpc_id
}

module "bastion" {
  source           = "../../modules/bastion"
  keypair          = module.keypair.OAPAAD_pub_key
  prv_key          = module.keypair.prv_key
  ami_redhat              = var.ami_redhat
  instance_type    = var.instance_type
  bastion_sg       = module.security_groups.bastion_sg
  OAPAADpubsub1_id = module.subnets.pubsub_1
}

module "route53" {
  source = "../../Modules/route53"
  docker-prod-lb-dns = module.docker-prod.docker_prod_lb_dns_name
  docker-prod-lb-zone-id = module.docker-prod.docker_prod_lb_zone_id
  lb_name = module.docker-prod.docker_prod_lb_dns_name
  zone_id = module.docker-prod.docker_prod_lb_zone_id
}
module "ASG" {
  source = "../../modules/ASG"
  keypair          = module.keypair.OAPAAD_pub_key
   ami_redhat               = var.ami_redhat
  instance_type = var.instance_type
  docker-prod_sg       = module.security_groups.docker-prod_sg
  OAPAADpubsub1_id = [module.subnets.pubsub_1, module.subnets.pubsub_2]
  OAPAAD-tgarn = module.docker-prod.docker_prod_target_group_arn
  source_instance_id = module.docker-prod.docker_prod_data_instance_id
  docker_instance = module.docker-prod.docker_prod_instance
}




