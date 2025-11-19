
resource "aws_subnet" "name" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "My Subnet"
  }
}