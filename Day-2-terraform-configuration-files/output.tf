output "publicIp" {
    value = aws_instance.name.id
  
}
output "az" {
    value = aws_instance.name.availability_zone
  
}
output "privateIp" {
    value = aws_instance.private_ip
  
}