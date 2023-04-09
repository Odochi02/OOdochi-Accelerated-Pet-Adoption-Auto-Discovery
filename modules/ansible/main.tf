#create ansible server 
resource "aws_instance" "OAPAAD_ansible" {
  ami                       = var.ami_ubuntu
  instance_type               = var.instance_type
  subnet_id                   = var.OAPAADprvsub1_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.ansible_sg]
  key_name                    = var.keypair
  iam_instance_profile = var.aws_instace_profile
  user_data                   = local.ansible_user_data
  
  # Connection Through SSH
  connection {
    type        = "ssh"
    private_key = (var.prv_key)
    user        = "ubuntu"
    host        = self.public_ip
  }

  tags = {
    Name = "OAPAAD_ansible"
  }

}

