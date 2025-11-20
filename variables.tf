variable "ami_value" {
  description = "Optional AMI ID override. Leave empty to use latest Ubuntu data lookup."
  type        = string
  default     = "" # empty means use data source fallback
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "sjm9"
}

variable "subnet_id" {
  description = "Optional subnet id to use (if empty we use subnet module's output)"
  type        = string
  default     = "subnet-0e3ef6c9aee3daf19"
}

variable "tags" {
  description = "Map of tags to apply"
  type        = map(string)
  default     = { Name = "from-root" }
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"  
}
variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "sjm-main-vpc"  
}     

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}