
# resource "aws_subnet" "my_public_subnet" {
#   vpc_id            = aws_vpc.name.id
#   cidr_block_       = var.cidr_block
#   availability_zone = var.availability_zone

#   tags = {
#     Name = "My Public Subnet"
#   }
# }

# resource "aws_subnet" "my_private_subnet" {
#   vpc_id            = aws_vpc.name.id
#   cidr_block        = var.cidr_block
#   availability_zone = var.availability_zone

#   tags = {
#     Name = "My Private Subnet"
#   }
# }

locals {
  base_tags = merge(
    {
      ManagedBy = "Terraform"
      Module    = "subnets"
    },
    var.tags
  )

  # Public CIDRs: carve from start of VPC /16
  # newbits = 8 turns /16 → /24
  public_cidrs = [
    for i in range(var.public_subnet) :
    cidrsubnet(var.vpc_cidr, 8, i)
  ]

  # Private CIDRs: carve from a different range (offset by +100) to avoid overlap
  private_cidrs = [
    for i in range(var.private_subnet) :
    cidrsubnet(var.vpc_cidr, 8, i + 100)
  ]

  # Distribute over AZs and create maps for for_each
  public_map = {
    for idx, cidr in local.public_cidrs :
    "pub-${idx}" => {
      cidr = cidr
      az   = var.azs[idx % length(var.azs)]
    }
  }

  private_map = {
    for idx, cidr in local.private_cidrs :
    "priv-${idx}" => {
      cidr = cidr
      az   = var.azs[idx % length(var.azs)]
    }
  }
}

# ----------------- PUBLIC SUBNETS -----------------
resource "aws_subnet" "public" {
  for_each = local.public_map

  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true # 🔑 public indicator #1

  tags = merge(local.base_tags, {
    Name = "${var.name_prefix}-${each.key}"
    Tier = "public"
  })
}

# Public route table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = merge(local.base_tags, {
    Name = "${var.name_prefix}-rt-public"
  })
}

# 0.0.0.0/0 → Internet Gateway: makes these subnets public  🔑 public indicator #2
resource "aws_route" "public_default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

# Attach all public subnets to the public route table
resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# ----------------- NAT GATEWAY IN PUBLIC SUBNET -----------------
resource "aws_eip" "nat" {
  count  = var.enable_nat_gateway && var.private_subnet > 0 ? 1 : 0
  domain = "vpc"

  tags = merge(local.base_tags, {
    Name = "${var.name_prefix}-eip-nat"
  })
}

resource "aws_nat_gateway" "this" {
  count = var.enable_nat_gateway && var.private_subnet > 0 ? 1 : 0

  allocation_id = aws_eip.nat[0].id
  subnet_id     = values(aws_subnet.public)[0].id # put NAT in first public subnet

  tags = merge(local.base_tags, {
    Name = "${var.name_prefix}-nat"
  })

  depends_on = [aws_route.public_default] # ensure IGW route exists first
}

# ----------------- PRIVATE SUBNETS -----------------
resource "aws_subnet" "private" {
  for_each = local.private_map

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  # no map_public_ip_on_launch → instances will NOT auto-get public IP
  tags = merge(local.base_tags, {
    Name = "${var.name_prefix}-${each.key}"
    Tier = "private"
  })
}

# Single private route table for all private subnets
resource "aws_route_table" "private" {
  count = var.private_subnet > 0 ? 1 : 0

  vpc_id = var.vpc_id

  tags = merge(local.base_tags, {
    Name = "${var.name_prefix}-rt-private"
  })
}

# 0.0.0.0/0 → NAT Gateway: private outbound internet
resource "aws_route" "private_default" {
  count = var.enable_nat_gateway && var.private_subnet > 0 ? 1 : 0

  route_table_id         = aws_route_table.private[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[0].id
}

# Attach private subnets to private route table
resource "aws_route_table_association" "private_assoc" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[0].id
}
