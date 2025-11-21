# provider "aws" {
#   region = "us-east-1"
# }

# # Data source (example fallback)
# /*data "aws_ami" "ubuntu" {
#   most_recent = true
#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
#   }
#   owners = ["099720109477"]
# }*/

# # Example VPC/subnet modules are assumed present; if not, you can stub them.
# # Here we assume subnet module returns `subnet_id` output.


# # EC2 module call
# module "ec2" {

#   source = "./Moduele/ec2"

#   ami_value     = var.ami_value
#   instance_type = var.instance_type
#   key_name      = var.key_name
#   # subnet_id     = var.subnet_id != "" ? var.subnet_id : module.subnet.subnet_id
#   subnet_id = var.subnet_id
#   tags      = var.tags
# }

# module "VPC" {

#   source = "./Moduele/VPC"

#   vpc_cidr = var.vpc_cidr
#   vpc_name = var.vpc_name
#   tags     = var.tags
# }

# module "subnet" {

#   source = "./Moduele/Subnets"

#   vpc_id            = module.VPC.vpc_id
#   cidr_block        = "10.0.1.0/24" 
#   availability_zone = "us-east-1a"
# }


terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "VPC" {
  source   = "./Moduele/VPC"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  tags     = var.tags
}

module "Subnets" {
  source         = "./Moduele/Subnets"
  name_prefix    = var.name_prefix
  vpc_id         = module.VPC.vpc_id
  vpc_cidr       = module.VPC.vpc_cidr
  azs            = var.azs
  public_subnet  = 1 # 1 public subnet
  private_subnet = 2 # 2 private subnets
  #enable_nat    = true
  igw_id = module.VPC.igw_id
  tags   = var.tags
}

# 1 EC2 in public subnet
module "ec2_public" {
  source              = "./Moduele/ec2"
  name_prefix         = "${var.name_prefix}-bastion"
  ami                 = var.ami
  instance_type       = var.instance_type
  subnet_id           = module.Subnets.public_subnet_ids[0]
  associate_public_ip = true
  tags                = var.tags
}

# EC2 in private subnet 1
module "ec2_private_a" {
  source              = "./Moduele/ec2"
  name_prefix         = "${var.name_prefix}-app-a"
  ami                 = var.ami
  instance_type       = var.instance_type
  subnet_id           = module.Subnets.private_subnet_ids[0]
  associate_public_ip = false
  tags                = var.tags
}

# EC2 in private subnet 2
module "ec2_private_b" {
  source              = "./Moduele/ec2"
  name_prefix         = "${var.name_prefix}-app-b"
  ami                 = var.ami
  instance_type       = var.instance_type
  subnet_id           = module.Subnets.private_subnet_ids[1]
  associate_public_ip = false
  tags                = var.tags
}
