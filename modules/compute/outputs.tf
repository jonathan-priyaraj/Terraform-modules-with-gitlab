output "public_servers" {
  value = aws_instance.public-servers.*.id
}

output "public_server_names" {
  value = aws_instance.public-servers.*.tags.Name
}

output "private_servers" {
  value = aws_instance.private-servers.*.id
}
