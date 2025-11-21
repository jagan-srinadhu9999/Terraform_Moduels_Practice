# output "vpc_id" {
#   value = aws_vpc.sjm_main_vpc
#    description = "VPC ID"
# } 

output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "CIDR of the VPC"
  value       = var.vpc_cidr
}

output "igw_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}
