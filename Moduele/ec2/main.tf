
# provider "aws" {
#   region = "us-east-1"

# }

# resource "aws_instance" "newwebserver" {
#   ami           = var.ami_value
#   instance_type = var.instance_type
#   key_name      = var.key_name
#   subnet_id     = var.subnet_id
#   tags          = var.tags
# } 

locals {
  base_tags = merge(
    {
      ManagedBy = "Terraform"
      Module    = "ec2"
    },
    var.tags
  )
}

# Look up subnet to get VPC ID
data "aws_subnet" "selected" {
  id = var.subnet_id
}

resource "aws_security_group" "this" {
  name        = "${var.name_prefix}-sg"
  description = "SG for ${var.name_prefix}"
  vpc_id      = data.aws_subnet.selected.vpc_id

  # Allow SSH from anywhere only for public instances.
  dynamic "ingress" {
    for_each = var.associate_public_ip ? [1] : []
    content {
      description = "SSH from Internet (tighten in real env!)"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # Egress: everything out
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.base_tags, {
    Name = "${var.name_prefix}-sg"
  })
}

resource "aws_instance" "this" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.this.id]
  associate_public_ip_address = var.associate_public_ip

  tags = merge(local.base_tags, {
    Name = var.name_prefix
  })
}
