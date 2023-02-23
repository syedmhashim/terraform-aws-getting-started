variable "prefix" {
    description = "(required) name prefix of the security group"
    type = string
}

variable "name" {
    description = "(required) name of the security group"
    type = string
}

variable "vpc_id" {
    description = "(optional) id of the security group's vpc"
    type = string
}

variable "description" {
    description = "(optional) description of the security group"
    type = string
    default = "security group"
}

variable "sg_ingress" {
    description = "(optional) ingress rules dictated by source security group"
    type = list(object({
      description = string
      protocol  = string
      from_port = number
      to_port   = number
      source_security_group_id = string
    }))
    default = []
}

variable "vpc_egress" {
    description = "(optional) egress rules dictated by cidr blocks"
    type = list(object({
      description = string
      protocol  = string
      from_port = number
      to_port   = number
      cidr_blocks = list(string)
    }))
    default = []
}

variable "vpc_ingress" {
    description = "(optional) ingress rules dictated by cidr blocks"
    type = list(object({
      description = string
      protocol  = string
      from_port = number
      to_port   = number
      cidr_blocks = list(string)
    }))
    default = []
}