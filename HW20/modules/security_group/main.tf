resource "aws_security_group" "this" {
  name   = "nginx-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["188.163.109.234/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "nginx-sg"
    Owner = "tophado1997@gmail.com"
  }
}
/*#resource "aws_vpc_security_group_ingress_rule" "allow_ports" {
  for_each = toset([
    for port in var.list_of_open_ports : tostring(port)
  ])

  security_group_id = aws_security_group.this.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = tonumber(each.value)
  to_port     = tonumber(each.value)
  ip_protocol = "tcp"

  description = "Allow ports ${each.value}"
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.this.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}*/