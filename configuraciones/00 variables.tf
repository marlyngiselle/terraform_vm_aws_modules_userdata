variable "NOMBRE_PROYECTO" {
  type    = string
  default = "neo"
}

variable "TIPO_INSTANCIA" {
  type    = string
  default = "t2.micro"
}

variable "BLOQUE_CIDR_VPC" {
  type    = string
  default = "10.0.0.0/16"
}

variable "BLOQUE_CIDR_SUBRED" {
  type    = string
  default = "10.0.150.0/24"
}

variable "INTERNET" {
  type    = string
  default = "0.0.0.0/0"
}

variable "AV_ZONES" {
  type = map(any)
  default = {
    a = "eu-west-3a"
    b = "eu-west-3b"
    c = "eu-west-3c"
  }
}

variable "IP_SERVIDOR_GUARDIAN" {
  type    = string
  default = "10.0.150.10"
}

variable "IMAGEN_OS" {
  type    = string
  default = ""
}

 