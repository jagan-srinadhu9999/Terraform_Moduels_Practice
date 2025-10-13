
ami_value     = "ami-0360c520857e3138f" # leave empty to use the AWS data lookup
instance_type = "t2.micro"
key_name      = "sjm8" # must exist in account if you're launching
subnet_id     = ""     # empty -> use module.subnet.subnet_id
tags = {
  Name = "dev-ec2"
}
