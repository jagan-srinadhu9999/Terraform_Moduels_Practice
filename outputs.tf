
# output "aws_instance_id" {
#   value       = module.ec2.instance_id
#   description = "EC2 instance id from module"

# }
# output "aws_instance_public_ip" {
#   value       = module.ec2.public_ip
#   description = "EC2 instance public IP from module"

# }
# output "aws_instance_public_dns" {
#   value       = module.ec2.public_dns
#   description = "EC2 instance public DNS from module"

# }

output "vpc_id" {
  value       = module.VPC.vpc_id
  description = "VPC ID"
}

output "public_subnet_ids" {
  value       = module.Subnets.public_subnet_ids
  description = "Public subnet IDs"
}

output "private_subnet_ids" {
  value       = module.Subnets.private_subnet_ids
  description = "Private subnet IDs"
}

output "bastion_public_ip" {
  value       = module.ec2_public.public_ip
  description = "Public IP of bastion instance"
}

output "app_private_ips" {
  value = [
    module.ec2_private_a.private_ip,
    module.ec2_private_b.private_ip
  ]
  description = "Private IPs of private app instances"
}
