output "ansible_IP" {
  value       = aws_instance.OAPAAD_ansible.private_ip
  description = "Ansible private IP"
}

  output "ansible_id" {
    value = aws_instance.OAPAAD_ansible.id

}

output "aws_instance_profile_id" {
  value = aws_iam_instance_profile.OAPAAD-Ansible-Node-profile.id
}