resource "aws_security_group" "bastion" {
  name        = "${var.s_group_client}-bastion"
  description = "Security Group for bastion"
  vpc_id      = var.s_group_vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.s_group_server_ip}/32"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.s_group_vpc_cidr]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.s_group_server_ip}/20"]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.s_group_vpc_cidr]
  }
  egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/20"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/20"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.s_group_client}-bastion"
  }
}
