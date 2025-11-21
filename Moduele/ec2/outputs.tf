
# output "instance_id" {
#   value       = aws_instance.newwebserver.id
#   description = "Module EC2 instance id"
# }

# output "public_ip" {
#   value       = aws_instance.newwebserver.public_ip
#   description = "Module EC2 public IP"
# }

# output "public_dns" {
#   value       = aws_instance.newwebserver.public_dns
#   description = "Module EC2 public DNS"
# }


output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "private_ip" {
  description = "Private IP"
  value       = aws_instance.this.private_ip
}

output "public_ip" {
  description = "Public IP (null if none)"
  value       = try(aws_instance.this.public_ip, null)
}
