locals {
  prefix = "${var.prefix}-${var.type}"
  subnet_name = "${local.prefix}-subnet"
  route_table_name = "${local.prefix}-rt"
  ngw_name = "${var.prefix}-ngw"
  eip_name = "${var.prefix}-eip"
}

variable prefix {
  type        = string
  description = "subnet name"
}

variable type {
  type        = string
  description = "type of subnet. Can be either public or private"
  validation {
    condition = contains(["private", "public"], var.type)
    error_message = "a subnet can either be public or private"
  }
}

variable availability_zone {
  type        = string
  description = "availability zone in which subnet would be created"
}


variable vpc_id {
  type        = string
  description = "id of the vpc in which subnet would be created"
}

variable "subnet_cidr" {
    description = "(required) cidr block for subnet"
    type    = string
}

variable igw_id {
  type = string
  default = null
  description = "internet gateway id"
}

variable ngw_id {
  type = string
  default = null
  description = "nat gateway id"
}

variable "create_ngw" {
  type = bool
  default = false
  description = "if set to true a nat gateway is created within the subnet. 'type' must be set to 'public' for this to work"
}

