output "web_sg_id" {
    description = "ID of the web security group"
    value = aws_security_group.security_group.id
}

output "app_sg_id" {
    description = "ID of the app security group"
    value = aws_security_group.security_group.id
}