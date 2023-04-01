output "OAPAAD_pub_key" {
  value = aws_key_pair.OAPAAD_pub_key.key_name
}

output "prv_key" {
  value = tls_private_key.OAPAAD_key.private_key_pem
}
