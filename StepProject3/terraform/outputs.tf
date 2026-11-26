output "ec2_instances" {
  value = {
    id                = aws_instance.master.id
    master_public_ip  = aws_instance.master.public_ip
    master_private_ip = aws_instance.master.private_ip
  }
}

output "ansible_inventory" {
  value = local_file.ansible_inventory.filename
}
