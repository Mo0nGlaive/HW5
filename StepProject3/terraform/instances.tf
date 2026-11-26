data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "master" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.subnet_public.id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #cloud-config
              users:
                - default
                - name: ubuntu
                  ssh_authorized_keys:
                    - ${file(var.public_key_path)}
              EOF

  tags = {
    Name  = "jenkins-master"
    Owner = "tophado1997@gmail.com"
  }
}

resource "aws_spot_instance_request" "worker" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.medium"
  spot_type              = "persistent"
  subnet_id              = aws_subnet.subnet_private.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  user_data = <<-EOF
              #cloud-config
              users:
                - default
                - name: ubuntu
                  ssh_authorized_keys:
                    - ${file(var.public_key_path)}
              EOF

  associate_public_ip_address = false

  tags = {
    Name  = "jenkins-worker"
    Owner = "tophado1997@gmail.com"
  }
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory.ini"

  content = templatefile(
    "${path.module}/inventory.tftpl",
    {
      master_public_ip  = aws_instance.master.public_ip
      worker_public_ip  = aws_spot_instance_request.worker.public_ip
      master_private_ip = aws_instance.master.private_ip
      private_key_path  = pathexpand(var.private_key_path)
    }
  )
}