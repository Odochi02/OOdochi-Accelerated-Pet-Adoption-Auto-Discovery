#Create Public Subnet1
resource "aws_subnet" "OAPAAD_pub_sn1" {
  vpc_id     = var.vpc_id
  cidr_block = var.OAPAADpubsub1_cidr
  availability_zone = "eu-west-2a"

  tags = {
    Name = "OAPAAD_pub_sn1"
  }
}

#Create Public Subnet2
resource "aws_subnet" "OAPAAD_pub_sn2" {
  vpc_id     = var.vpc_id
  cidr_block = var.OAPAADpubsub2_cidr
  availability_zone = "eu-west-2b"

  tags = {
    Name = "OAPAAD_pub_sn2"
  }
}

#Create Private Subnet1
resource "aws_subnet" "OAPAAD_prv_sn1" {
  vpc_id     = var.vpc_id
  cidr_block = var.OAPAADprvsub1_cidr
  availability_zone = "eu-west-2a"

  tags = {
    Name = "OAPAAD_prv_sn1"
  }
}

#Create Private Subnet2
resource "aws_subnet" "OAPAAD_prv_sn2" {
  vpc_id     = var.vpc_id
  cidr_block = var.OAPAADprvsub2_cidr
  availability_zone = "eu-west-2b"

  tags = {
    Name = "OAPAAD_prv_sn2"
  }
}

#Create Internet Gateway
resource "aws_internet_gateway" "OAPAAD_igw" {
  vpc_id =  var.vpc_id

  tags = {
    Name = "OAPAAD_igw"
  }
}

# Create Elastic IP for NAT Gateway
resource "aws_eip" "OAPAAD_nat_eip" {
  vpc = true

  tags = {
    Name = "OAPAAD_nat_eip"
  }
}

# Create NAT Gateway
resource "aws_nat_gateway" "OAPAAD_ngw" {
  allocation_id = aws_eip.OAPAAD_nat_eip.id
  subnet_id     = aws_subnet.OAPAAD_pub_sn1.id

  tags = {
    Name = "OAPAAD_ngw"
  }
}

# Create Route Table for Public Subnet
resource "aws_route_table" "OAPAAD_pub_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.all_ip
    gateway_id = aws_internet_gateway.OAPAAD_igw.id
  }

  tags = {
    Name = "OAPAAD_pub_rt"
  }
}

# Create Route Table for Private Subnet
resource "aws_route_table" "OAPAAD_prv_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.all_ip
    nat_gateway_id = aws_nat_gateway.OAPAAD_ngw.id
  }

  tags = {
    Name = "OAPAAD_prv_rt"
  }
}


# Create Route-Table Association for Public Subnet 1
resource "aws_route_table_association" "OAPAAD_pub_sub_rt_as1" {
  subnet_id      = aws_subnet.OAPAAD_pub_sn1.id
  route_table_id = aws_route_table.OAPAAD_pub_rt.id
}
# Create Route-Table Association for Public Subnet 2
resource "aws_route_table_association" "OAPAAD_pub_sub_rt_as2" {
  subnet_id      = aws_subnet.OAPAAD_pub_sn2.id
  route_table_id = aws_route_table.OAPAAD_pub_rt.id
}

# Create Route-Table Association for Private Subnet 1
resource "aws_route_table_association" "OAPAAD_prv_sub_rt_as1" {
  subnet_id      = aws_subnet.OAPAAD_prv_sn1.id
  route_table_id = aws_route_table.OAPAAD_prv_rt.id
}

# Create Route-Table Association for Private Subnet 2
resource "aws_route_table_association" "OAPAAD_prv_sub_rt_as2" {
  subnet_id      = aws_subnet.OAPAAD_prv_sn2.id
  route_table_id = aws_route_table.OAPAAD_prv_rt.id
}