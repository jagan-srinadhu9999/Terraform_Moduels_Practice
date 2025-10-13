variable "ami_value" {
  description = "value of ami"
  type        = string
}
variable "instance_type" {
  description = "Type of instance"
  type        = string

}
variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string

}
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = { Name = "from-root" }
}