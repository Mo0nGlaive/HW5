output "vpc_id" {
  value       = aws_vpc.vpc.vpc_id
}

output "public_ec2_ip" {
  value = aws_instance.public.public_ip
}

output "private_ec2_ip" {
  value = aws_instance.private.private_ip
}

output "vpc_cidr_block" {
  value       = aws_vpc.vpc.vpc_cidr_block
}

output "public_subnet" {
  value       = aws_vpc.vpc.public_subnets
}

output "private_subnet" {
  value       = aws_vpc.vpc.private_subnets
}

output "nat_public_ips" {
  value       = aws_vpc.vpc.nat_public_ips
}

output "public_ssh_sg_id" {
  value       = aws_security_group.public_ssh_sg.id
}

output "private_ssh_sg_id" {
  value       = aws_security_group.private_ssh_sg.id
}