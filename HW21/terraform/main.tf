data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
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

resource "aws_key_pair" "main" {
  key_name   = "terraform"
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "ansible-nginx" {
  name   = "ansible-nginx"
  vpc_id = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
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
    Name = "ansible-nginx-sg"
  }
}

resource "aws_instance" "nginx" {
  count         = 2
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id = element(
    data.aws_subnets.default.ids,
    count.index % length(data.aws_subnets.default.ids)
  )
  key_name = aws_key_pair.main.key_name

  vpc_security_group_ids = [
    aws_security_group.ansible-nginx.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "nginx-${count.index + 1}"
  }
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory.ini"

  content = templatefile(
    "${path.module}/inventory.tftpl",
    {
      instances        = aws_instance.nginx
      private_key_path = pathexpand(var.private_key_path)
    }
  )
}