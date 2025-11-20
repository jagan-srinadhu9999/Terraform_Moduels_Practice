
resource "aws_subnet" "my_public_subnet" {
  vpc_id            = aws_vpc.name.id
  cidr_block_       = var.cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "My Public Subnet"
  }
}

resource "aws_subnet" "my_private_subnet" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "My Private Subnet"
  }
}