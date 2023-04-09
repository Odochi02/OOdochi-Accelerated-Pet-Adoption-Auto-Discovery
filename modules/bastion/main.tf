# Provisioning Bastion Host
resource "aws_instance" "Bastion_host" {
  ami                         = var.ami_redhat
  instance_type               = var.instance_type
  key_name                    = var.keypair
  subnet_id                   = var.OAPAADpubsub1_id
  vpc_security_group_ids      = [var.bastion_sg]
  associate_public_ip_address = true
  user_data = <<-EOF
#!/bin/bash
echo "${var.prv_key}" > /home/ec2-user/OAPAAD_prv
sudo chmod 400 OAPAAD_prv
sudo hostnamectl set-hostname Bastion
EOF 

  tags = {
    Name = "Bastion_host"
  }
}
