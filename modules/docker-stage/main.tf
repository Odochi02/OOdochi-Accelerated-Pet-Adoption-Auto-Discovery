
#Create Docker Server
resource "aws_instance" "docker_stage" {
  ami                       = var.ami_redhat
  instance_type               = var.instance_type
  subnet_id                   = var.OAPAADprvsub1_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.docker-stage_sg]
  key_name                    = var.keypair
  user_data              = local.docker_user_data

  tags = {
    Name = "docker_stage"
  }
}