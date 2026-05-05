output "instance_ids" {
  value = aws_instance.this[*].id
}

output "instance_ips" {
  value = aws_instance.this[*].public_ip
}

output "instance_dns" {
  value = aws_instance.this[*].public_dns
}

output "security_group_id" {
  value = aws_security_group.this.id
}
