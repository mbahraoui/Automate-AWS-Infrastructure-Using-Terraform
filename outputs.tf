output "ec2_public_ip" {
  value = module.myapp-webserver.webserver.public_ip
}