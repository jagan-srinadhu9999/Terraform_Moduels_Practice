
ami_value     = ""            # leave empty to use the AWS data lookup
instance_type = "t2.micro"
key_name      = "sjm9"        # must exist in account if you're launching
subnet_id     = ""            # empty -> use module.subnet.subnet_id
tags = {
  Name = "dev-ec2"
}
