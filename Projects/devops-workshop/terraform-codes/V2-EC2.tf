provider "aws" {
    region  = "us-east-1"
}

 resource "aws_instance" "demo-server" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"
  key_name = "Key33_2"
  security_groups = "demo-sg"
 }

 resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  description = "ssh access"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "ssh-port"
  }
}

resource "aws_vpc_security_group_ingress_rule" "demo-sg_ipv4" {
  security_group_id = aws_security_group.demo-sg.id
  cidr_ipv4         = ["0.0.0.0/0"]
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.demo-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

