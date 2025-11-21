# variable "cidr_block" {
#   description = "The CIDR block for the subnet"
#   type        = string

# }

# variable "availability_zone" {
#   description = "The availability zone for the subnet"
#   type        = string

# }
#variables of subnet module

variable "name_prefix" {
  description = "Name prefix for subnet and route table tags"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where subnets will be created"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR of the VPC, e.g. 10.0.0.0/16"
  type        = string
}

variable "igw_id" {
  description = "Internet Gateway ID attached to this VPC"
  type        = string
}

variable "azs" {
  description = "List of AZs to spread subnets across"
  type        = list(string)
}

variable "public_subnet" {
  description = "How many public /24 subnets to create"
  type        = number
}

variable "private_subnet" {
  description = "How many private /24 subnets to create"
  type        = number
}

variable "enable_nat_gateway" {
  description = "Whether to create a single NAT gateway for private subnets"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags for all subnet and route table resources"
  type        = map(string)
  default     = {}
}
