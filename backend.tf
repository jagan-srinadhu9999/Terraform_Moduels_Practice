## Backend Configuration for terrraform state in s3 and lock in s3

terraform {
  backend "s3" {
    bucket       = "remote-state-backent-tf"
    key          = "envs/dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true    # <-- native S3 locking
  }
}
