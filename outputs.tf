
output "aws_instance_id" {
  value       = module.ec2.instance_id
  description = "EC2 instance id from module"

}
output "aws_instance_public_ip" {
  value       = module.ec2.public_ip
  description = "EC2 instance public IP from module"

}
output "aws_instance_public_dns" {
  value       = module.ec2.public_dns
  description = "EC2 instance public DNS from module"

}