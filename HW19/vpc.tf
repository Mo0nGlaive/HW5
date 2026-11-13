resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name  = "hw19_vpc"
    Owner = "tophado1997@gmail.com"
  }
}

resource "aws_subnet" "subnet_public" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name  = "hw19_subnet_public"
    Owner = "tophado1997@gmail.com"
  }
}

resource "aws_subnet" "subnet_private" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name  = "hw19_subnet_private"
    Owner = "tophado1997@gmail.com"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name  = "hw19_igw"
    Owner = "tophado1997@gmail.com"
  }
}

resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
    Name  = "hw19_eip"
    Owner = "tophado1997@gmail.com"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subnet_private.id

  tags = {
    Name  = "hw19_nat"
    Owner = "tophado1997@gmail.com"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name  = "hw19_public_rt"
    Owner = "tophado1997@gmail.com"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name  = "hw19_private_rt"
    Owner = "tophado1997@gmail.com"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.subnet_private.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "public_sg" {
  name   = "public-ssh-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "hw19_public_sg"
    Owner = "tophado1997@gmail.com"
  }
}

resource "aws_security_group" "private_sg" {
  name   = "private-ssh-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.subnet_private.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "hw19_private_sg"
    Owner = "tophado1997@gmail.com"
  }
}
