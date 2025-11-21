# variable "vpc_cidr" {
#   description = "vpc cidr pool"
#   type        = string
# }
# variable "vpc_name" {
#   description = "Name of the VPC"
#   type        = string
# }

# variable "tags" {
#   description = "Common tags"
#   type        = map(string)
#   default     = {}
# }


variable "vpc_cidr" {
  description = "CIDR block for the VPC, e.g. 10.0.0.0/16"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC (used in tags)"
  type        = string
}

variable "tags" {
  description = "Common tags applied to VPC resources"
  type        = map(string)
  default     = {}
}
