resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name  = "hw20_vpc"
    Owner = "tophado1997@gmail.com"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.0/16"
  availability_zone = "eu-central-1a"

  tags = {
    Name  = "hw20_public"
    Owner = "tophado1997@gmail.com"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name  = "hw20_public"
    Owner = "tophado1997@gmail.com"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name  = "hw20_public"
    Owner = "tophado1997@gmail.com"
  } 
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    ]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "security_group" {
  source = "./modules/security_group"

  vpc_id             = aws_vpc.vpc.id
  list_of_open_ports = var.list_of_open_ports
}

resource "aws_key_pair" "main" {
  key_name = "ubuntu-work"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "nginx" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public.id
  key_name = aws_key_pair.main.key_name

  vpc_security_group_ids = [
    module.security_group.security_group_id
  ]

  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    set -e

    apt-get update
    apt-get install -y nginx

    systemctl enable nginx
    systemctl start nginx
  EOF

  user_data_replace_on_change = true

  tags = {
    Name = "terraform-nginx-server"
  }
}
