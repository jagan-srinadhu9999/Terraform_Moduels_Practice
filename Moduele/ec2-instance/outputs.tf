
output "instance_id" {
  value       = aws_instance.newwebserver.id
  description = "Module EC2 instance id"
}

output "public_ip" {
  value       = aws_instance.newwebserver.public_ip
  description = "Module EC2 public IP"
}

output "public_dns" {
  value       = aws_instance.newwebserver.public_dns
  description = "Module EC2 public DNS"
}
