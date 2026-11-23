output "ec2_instances" {
  value = {
    for index, instance in aws_instance.nginx :
    instance.tags.Name => {
      id         = instance.id
      public_ip  = instance.public_ip
      public_dns = instance.public_dns
    }
  }
}

output "ansible_inventory" {
  value = local_file.ansible_inventory.filename
}
