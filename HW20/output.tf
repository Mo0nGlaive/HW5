output "ec2_public_ip" {
  value = aws_instance.nginx.public_ip
}

output "ec2_instance_id" {
  value = aws_instance.nginx.id
}

output "security_group_id" {
  value = module.security_group.security_group_id
}

output "nginx_url" {
  value = "${aws_instance.nginx.public_ip}"
}