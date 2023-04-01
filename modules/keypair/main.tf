# create KeyPair 
resource "tls_private_key" "OAPAAD_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "OAPAAD_prv" {
  content  = tls_private_key.OAPAAD_key.private_key_pem
  filename = "OAPAAD_prv"
}


resource "aws_key_pair" "OAPAAD_pub_key" {
  key_name   = "OAPAAD_pub_key"
  public_key = tls_private_key.OAPAAD_key.public_key_openssh
}