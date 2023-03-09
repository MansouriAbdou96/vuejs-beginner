output "vuejs-ip" {
  description = "Public IP of the petclinic server"
  value       = aws_instance.vuejs_server.public_ip
}

output "vuejs-dns" {
  description = "DNS of the petclinic server"
  value       = aws_instance.vuejs_server.public_dns
}