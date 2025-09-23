provider "aws" {
  region = "us-east-1"
}

# Data source (example fallback)
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}

# Example VPC/subnet modules are assumed present; if not, you can stub them.
# Here we assume subnet module returns `subnet_id` output.
module "subnet" {
  source = "../modules/subnet"
  # if you don't have real module, it's fine for syntax checking
}

# EC2 module call
module "ec2-instance" {
  source        = "./modules/ec2-instance"

  # mapping root -> module
  ami           = var.ami_value != "" ? var.ami_value : data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id != "" ? var.subnet_id : module.subnet.subnet_id
  tags          = var.tags
}
