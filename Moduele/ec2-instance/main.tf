
provider "aws" {
  region = "us-east-1"  
  
}

resource "aws_instance" "newwebserver" {
  ami= var.ami_value
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.subnet_id
    tags = var.tags
}