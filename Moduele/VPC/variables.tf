variable "vpc_cidr" {
  description = "vpc cidr pool"
  type        = string
}
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}