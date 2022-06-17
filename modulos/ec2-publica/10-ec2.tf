variable "NOMBRE_PROYECTO" {
  type    = string
  default = ""
}

variable "TIPO_INSTANCIA" {
  type    = string
  default = ""
}

variable "IP_SERVIDOR_GUARDIAN" {
  type    = string
  default = ""
}

variable "IMAGEN_OS" {
  type    = string
  default = ""
}

variable "ID_SUBRED" {
  type    = string
  default = ""
}

variable "IDS_SEC_GROUPS" {
  type    = list
  default = []
}

variable "LLAVE_SSH_PUBLICA" {
  type    = string
  default = ""
}

variable "NUMERO" {
  type    = string
  default = ""
}

variable "LISTA_NOMBRE_SERVIDORES"{
  type = list
  default = []
}

data "template_file" "mi_bootstrap" {
  template = "${file("~//ps/terraform/proyecto/modulos/ec2-publica/bootstrap.sh")}"
  vars = {
    EL_HOSTNAME = var.LISTA_NOMBRE_SERVIDORES[var.NUMERO]

  }
  
}

resource "aws_instance" "mi_vm" {
  tags                   = {Name = "vm-${var.NOMBRE_PROYECTO}-${var.NUMERO+1}" }
  ami                    = var.IMAGEN_OS
  instance_type          = var.TIPO_INSTANCIA
  subnet_id              = var.ID_SUBRED
  vpc_security_group_ids = var.IDS_SEC_GROUPS
  key_name               = var.LLAVE_SSH_PUBLICA
  private_ip             = var.IP_SERVIDOR_GUARDIAN
  user_data              = "${data.template_file.mi_bootstrap.rendered}"

}

output "la_ip_publica" {
  value = aws_instance.mi_vm.public_ip
}

output "la_ip_privada" {
  value = aws_instance.mi_vm.private_ip
}
