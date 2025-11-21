
# ami_value     = "ami-0360c520857e3138f" # leave empty to use the AWS data lookup
# instance_type = "t2.micro"
# key_name      = "sjm8" # must exist in account if you're launching
# subnet_id     = ""     # empty -> use module.subnet.subnet_id
# tags = {
#   Name = "dev-ec2"
# }

# #vpc variables
# vpc_cidr = "10.0.0.0/16"
# vpc_name = "sjm-main-vpc"
# tags = {
#   Name = "sjm-main-vpc"
# }

# #subnet variables
# vpc_id            = ""  # will be set from module.VPC.vpc_id
# cidr_block        = "10.0.1.0/24"
# availability_zone = "us-east-1a"  

##############################################
# Environment Name / Naming
##############################################
name_prefix = "sjm-dev"

##############################################
# AWS Region
##############################################
aws_region = "us-east-1"

##############################################
# VPC Configuration
##############################################
vpc_cidr = "10.0.0.0/16"
vpc_name = "sjm-main-vpc"

##############################################
# Subnet Configuration (root-level variables, 
# only if you added them in variables.tf)
##############################################
# If your root variables.tf has:
# variable "public_subnet" {...}
# variable "private_subnet" {...}
# variable "enable_nat_gateway" {...}
# then you can also set:
#
# public_subnet      = 1
# private_subnet     = 2
# enable_nat_gateway = true

##############################################
# EC2 / Compute
##############################################
# Use a valid Ubuntu/AMI in your region
ami           = "ami-0360c520857e3138f" # replace if needed
instance_type = "t2.micro"

##############################################
# Common Tags
##############################################
tags = {
  Environment = "dev"
  Project     = "SJM"
  ManagedBy   = "Terraform"
}
