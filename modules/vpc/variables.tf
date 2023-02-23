locals {
  vpc_name = "${var.prefix}-vpc"
  igw_name = "${var.prefix}-igw"
}

variable "prefix" {
    description = "(required) vpc name"
    type = string
}

variable "vpc_cidr" {
    description = "(required) root cidr block for vpc"
    type    = string
}