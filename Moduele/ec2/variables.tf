# variable "ami_value" {
#   description = "value of ami"
#   type        = string
# }
# variable "instance_type" {
#   description = "Type of instance"
#   type        = string

# }
# variable "key_name" {
#   description = "Key pair name"
#   type        = string
# }

# variable "subnet_id" {
#   description = "Subnet ID"
#   type        = string

# }
# variable "tags" {
#   description = "Tags to apply to resources"
#   type        = map(string)
#   default     = { Name = "from-root" }
# } 

variable "name_prefix" {
  description = "Instance name prefix"
  type        = string
}

variable "ami" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch into"
  type        = string
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
