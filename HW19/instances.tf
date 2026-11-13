data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_key_pair" "main" {
  key_name   = "terraform-vpc-key"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "public_ec2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet_public.id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  key_name                    = aws_key_pair.main.key_name
  associate_public_ip_address = true

  tags = {
    Name = "public-ec2"
    Owner = "tophado1997@gmail.com"
  }
}

resource "aws_instance" "private_ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet_private.id
  vpc_security_group_ids = [aws_security_group.private.id]
  key_name               = aws_key_pair.main.key_name

  associate_public_ip_address = false

  tags = {
    Name = "private-ec2"
    Owner = "tophado1997@gmail.com"
  }
}