# Create VPC
resource "aws_vpc" "OAPAAD_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "OAPAAD_vpc"
  }
}