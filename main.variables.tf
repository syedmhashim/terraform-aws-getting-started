locals {
  subnet = {
    public = {
      cidr_block = cidrsubnet(var.vpc_cidr, 8, 0)
      availability_zone = "us-east-1a"
    }
    private = {
      cidr_block = cidrsubnet(var.vpc_cidr, 8, 1)
      availability_zone = "us-east-1b"
    }
  }
}


variable "shared_prefix" {}
variable "vpc_cidr" {}
variable "ec2_sg" {}