resource "aws_key_pair" "llave-ssh-neo" {
  key_name   = "llave-ssh-${var.NOMBRE_PROYECTO}"
  public_key = file("~/.ssh/id_ed25519.pub")

}

resource "aws_security_group" "firewall_instancia" {
  tags        = { Name = "sg-${var.NOMBRE_PROYECTO}" }
  name        = "${var.NOMBRE_PROYECTO}-sg"
  description = "Firewall de las instancias publicas"
  vpc_id      = aws_vpc.mi_vpc.id

  ingress {
    description = "Acceso Puerto SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.INTERNET]
  }

  ingress {
    description = "permite_ping"
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [var.INTERNET]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.INTERNET]
  }

}

resource "aws_network_acl" "firewall_subred" {
  vpc_id = aws_vpc.mi_vpc.id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

}

