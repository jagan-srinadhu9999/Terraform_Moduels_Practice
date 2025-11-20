provider "aws" {
  region = "us-east-1"
}

# Data source (example fallback)
/*data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}*/

# Example VPC/subnet modules are assumed present; if not, you can stub them.
# Here we assume subnet module returns `subnet_id` output.


# EC2 module call
module "ec2" {

  source = "./Moduele/ec2"

  ami_value     = var.ami_value
  instance_type = var.instance_type
  key_name      = var.key_name
  # subnet_id     = var.subnet_id != "" ? var.subnet_id : module.subnet.subnet_id
  subnet_id = var.subnet_id
  tags      = var.tags
}

module "VPC" {

  source = "./Moduele/VPC"

  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  tags     = var.tags
}

module "subnet" {

  source = "./Moduele/Subnets"

  vpc_id            = module.VPC.vpc_id
  cidr_block        = "10.0.1.0/24" 
  availability_zone = "us-east-1a"
}
