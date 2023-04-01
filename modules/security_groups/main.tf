# Create Ansible Security Group
resource "aws_security_group" "OAPAAD_ansible_sg" {
  name        = "OAPAAD_ansible_sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id


  ingress {
    description = "Allow ssh traffic"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    security_groups = [aws_security_group.OAPAAD_bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ip]
  }

  tags = {
    Name = "OAPAAD_ansible_sg"
  }
}

# Create Sonarqube Security Group
resource "aws_security_group" "OAPAAD_sonarqube_sg" {
  name        = "OAPAAD_sonarqube_sg"
  description = "Allow Jenkins traffic"
  vpc_id      = var.vpc_id


  ingress {
    description      = "sonarqube"
    from_port        = var.sonarqube_port
    to_port          = var.sonarqube_port
    protocol         = "tcp"
    cidr_blocks = [var.all_ip]
  }

  ingress {
    description      = "SSH"
    from_port        = var.ssh_port
    to_port          = var.ssh_port
    protocol         = "tcp"
    cidr_blocks = [var.all_ip]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks = [var.all_ip]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "OAPAAD_sonarqube_sg"
  }
}

# Create Docker-PROD Security Group
resource "aws_security_group" "OAPAAD_docker-prod_sg" {
  name        = "OAPAAD_docker-prod_sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  
ingress {
    description      = "SSH"
    from_port        = var.ssh_port
    to_port          = var.ssh_port
    protocol         = "tcp"
    security_groups = [aws_security_group.OAPAAD_bastion_sg.id]
}
   
  ingress {
    description      = "SSH"
    from_port        = var.ssh_port
    to_port          = var.ssh_port
    protocol         = "tcp"
    security_groups = [aws_security_group.OAPAAD_ansible_sg.id]
  }

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    security_groups = [aws_security_group.OAPAAD_docker_prod_lb_sg.id]
    }

  ingress {
    description      = "APPLICATION"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    security_groups = [aws_security_group.OAPAAD_docker_prod_lb_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "OAPAAD_docker-prod_sg"
  }
}

# Create Docker-Stage Security Group
resource "aws_security_group" "OAPAAD_docker-stage_sg" {
  name        = "OAPAAD_docker-stage_sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  
ingress {
    description      = "SSH"
    from_port        = var.ssh_port
    to_port          = var.ssh_port
    protocol         = "tcp"
    security_groups = [aws_security_group.OAPAAD_bastion_sg.id]
}
   
  ingress {
    description      = "SSH"
    from_port        = var.ssh_port
    to_port          = var.ssh_port
    protocol         = "tcp"
    security_groups = [aws_security_group.OAPAAD_ansible_sg.id]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [aws_security_group.OAPAAD_docker_prod_lb_sg.id]
  }

ingress {
    description      = "APPLICATION"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    security_groups = [aws_security_group.OAPAAD_docker_stage_lb_sg.id]
}

ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [aws_security_group.OAPAAD_docker_stage_lb_sg.id]
}

ingress {
    description      = "APPLICATION"
    from_port        = 8085
    to_port          = 8085
    protocol         = "tcp"
    security_groups = [aws_security_group.OAPAAD_docker_stage_lb_sg.id]
}
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "OAPAAD_docker-stage_sg"
  }
}

# Create Security Group for Bastion Host 
resource "aws_security_group" "OAPAAD_bastion_sg" {
  name        = "OAPAAD_bastion_sg"
  description = "Allow traffic for ssh"
  vpc_id      = var.vpc_id

  
  ingress {
    description = "SSH"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # my computer ip address
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "OAPAAD_bastion_sg"
  }
}

#creating jenkins lb security group 
resource "aws_security_group" "OAPAAD_jenkins_lb_sg" {
  name        = "OAPAAD_jenkins_lb_sg"
  description = "Allow Jenkins traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Proxy Traffic"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "OAPAAD_jenkins_lb_sg"
  }
}

# Create Jenkins Security Group
resource "aws_security_group" "OAPAAD_jenkins_sg" {
  name        = "OAPAAD_jenkins_sg"
  description = "Allow Jenkins traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Proxy traffic"
    from_port   = var.jenkins_port
    to_port     = var.jenkins_port
    protocol    = "tcp"
    cidr_blocks = [var.all_ip]
  }


  ingress {
    description = "Allow SSH traffic"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ip]
  }

  
  tags = {
    Name = "OAPAAD_jenkins_sg"
  }
  }

  #creating docker stage lb security group 
resource "aws_security_group" "OAPAAD_docker_stage_lb_sg" {
  name        = "var.vpc_id_docker_stage_lb_sg"
  description = "Allow Docker traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Proxy Traffic"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "OAPAAD_docker_stage_lb_sg"
  }
}

#creating docker prod lb security group 
resource "aws_security_group" "OAPAAD_docker_prod_lb_sg" {
  name        = "OAPAAD_docker_prod_lb_sg"
  description = "Allow Docker traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Proxy Traffic"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "OAPAAD_docker_prod_lb_sg"
  }
}



