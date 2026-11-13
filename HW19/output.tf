output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "VPC cidr block"
  value       = aws_vpc.vpc.cidr_block
}

output "public_subnet" {
  value = {
    id                = aws_subnet.subnet_public.id
    cidr              = aws_subnet.subnet_public.cidr_block
    availability_zone = aws_subnet.subnet_public.availability_zone
    public_ip_mapping = aws_subnet.subnet_public.map_public_ip_on_launch
  }
}

output "private_subnet" {
  value = {
    id                = aws_subnet.subnet_private.id
    cidr              = aws_subnet.subnet_private.cidr_block
    availability_zone = aws_subnet.subnet_private.availability_zone
    public_ip_mapping = aws_subnet.subnet_private.map_public_ip_on_launch
  }
}

output "internet_gateway" {
  value = {
    id     = aws_internet_gateway.igw.id
    vpc_id = aws_internet_gateway.igw.vpc_id
  }
}

output "nat_gateway" {
  value = {
    id         = aws_nat_gateway.nat.id
    subnet_id  = aws_nat_gateway.nat.subnet_id
    public_eip = aws_eip.eip.id
    public_ip  = aws_eip.eip.public_ip
  }
}

output "public_route_table" {
  value = {
    id          = aws_route_table.public_rt.id
    vpc_id      = aws_route_table.public_rt.vpc_id
    subnet_id   = aws_subnet.subnet_public.id
    destination = "0.0.0.0/0"
    target      = aws_internet_gateway.igw.id
  }
}

output "private_route_table" {
  value = {
    id          = aws_route_table.private_rt.id
    vpc_id      = aws_route_table.private_rt.vpc_id
    subnet_id   = aws_subnet.subnet_private.id
    destination = "0.0.0.0/0"
    target      = aws_nat_gateway.nat.id
  }
}

output "public_security_group" {
  value = {
    id      = aws_security_group.public_sg.id
    name    = aws_security_group.public_sg.name
    vpc_id  = aws_security_group.public_sg.vpc_id
    ingress = aws_security_group.public_sg.ingress
    egress  = aws_security_group.public_sg.egress
  }
}

output "private_security_group" {
  value = {
    id      = aws_security_group.private_sg.id
    name    = aws_security_group.private_sg.name
    vpc_id  = aws_security_group.private_sg.vpc_id
    ingress = aws_security_group.private_sg.ingress
    egress  = aws_security_group.private_sg.egress
  }
}

output "public_ec2" {
  value = {
    id         = aws_instance.public_ec2.id
    public_ip  = aws_instance.public_ec2.public_ip
    private_ip = aws_instance.public_ec2.private_ip
    subnet_id  = aws_instance.public_ec2.subnet_id
  }
}

output "private_ec2" {
  value = {
    id         = aws_instance.private_ec2.id
    private_ip = aws_instance.private_ec2.private_ip
    subnet_id  = aws_instance.private_ec2.subnet_id
  }
}
