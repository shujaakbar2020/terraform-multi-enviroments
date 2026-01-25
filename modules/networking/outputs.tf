output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.public.id
}

output "security_group_ids" {
  value = [
    aws_security_group.public_sg.id,
    aws_security_group.private_sg.id
  ]
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}