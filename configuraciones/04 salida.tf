output "PUBLIC_IP_de_vm" {
  value = module.ec2_jenkins[*].la_ip_publica
}

output "PRIVATE_IP_de_vm" {
  value = module.ec2_jenkins[*].la_ip_privada
}
