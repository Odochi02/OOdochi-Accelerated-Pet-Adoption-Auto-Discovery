#Create Docker Server
resource "aws_instance" "docker_prod" {
  ami                       = var.ami_redhat
  instance_type               = var.instance_type
  subnet_id                   = var.OAPAADprvsub1_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.docker-prod_sg]
  key_name                    = var.keypair
  user_data              = local.docker_user_data

  tags = {
    Name = "docker_prod"
  }
}

data "aws_instance" "docker_prod" {
  filter {
    name   = "tag:Name"
    values = ["docker_prod"]
  }
  depends_on = [
    aws_instance.docker_prod
  ]
}