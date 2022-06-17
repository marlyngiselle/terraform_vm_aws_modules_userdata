data "aws_ami" "os_ubuntu" {
  owners      = ["099720109477"] #canonical -Empresa que hace ubuntu
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

module "ec2_jenkins" {
  count                   = 3
  source                  = "..//modulos/ec2-publica"
  NOMBRE_PROYECTO         = "jenkins"
  TIPO_INSTANCIA          = "t2.micro"
  NUMERO                  = count.index
  IP_SERVIDOR_GUARDIAN    = "10.0.150.1${count.index}"
  IMAGEN_OS               = data.aws_ami.os_ubuntu.id
  ID_SUBRED               = aws_subnet.subred_publica.id
  IDS_SEC_GROUPS          = [aws_security_group.firewall_instancia.id]
  LLAVE_SSH_PUBLICA       = aws_key_pair.llave-ssh-neo.key_name
  LISTA_NOMBRE_SERVIDORES = ["saturno", "jupiter", "pluton"]
}

