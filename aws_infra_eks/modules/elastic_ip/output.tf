output "elastic_ip" {
  value = aws_eip.nat.id
}