output "vpc_id" {
  description = "ID VPC"
  #value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR VPC"
  #value       = module.vpc.vpc_cidr_block
}

output "public_subnet" {
  description = "ID public_sub"
  #value       = module.vpc.public_subnets
}

output "private_subnet" {
  description = "ID private_sub"
  #value       = module.vpc.private_subnets
}

output "nat_public_ips" {
  description = "NAT EIP"
  #value       = module.vpc.nat_public_ips
}


output "public_ssh_sg_id" {
  description = "Public sg"
  value       = aws_security_group.public_ssh_sg.id
}

output "private_ssh_sg_id" {
  description = "Private sg"
  value       = aws_security_group.private_ssh_sg.id
}