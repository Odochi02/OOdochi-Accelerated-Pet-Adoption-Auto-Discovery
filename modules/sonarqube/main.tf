#create sonarqube server
resource "aws_instance" "OAPAAD_sonarqube" {
  ami                       = var.ami_ubuntu
  instance_type               = var.instance_type
  subnet_id                   = var.OAPAADpubsub1_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sonarqube_sg]
  key_name                    = var.keypair
  user_data              = local.sonarqube_user_data

  tags = {
    Name = "OAPAAD_sonarqube"
  }
}


