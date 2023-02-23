locals {
  instance_name = "${var.prefix}-instance"
  key_name = "${var.prefix}-key"
  key_file_name = "${local.key_name}.pem"
}

variable prefix {
  type        = string
  description = "name of the instance"
}

variable ami {
  type        = string
  default     = "ami-0cff7528ff583bf9a"
  description = "ami of the instance"
}

variable enable_public_ip  {
  type        = bool
  default     = true
  description = "associate a public ip address with the instance"
}


variable type {
  type        = string
  default     = "t2.micro"
  description = "type of instance"
}

variable subnet_id {
  type = string
  description = "subnet id in which the instance will be provisioned"
}

variable sg_ids {
  type = list
  description = "list of security group ids that would be attached to the instance"
}

variable key_name {
  type = string
  default = null
  description = "key name of the key pair to use for the instance"
}

variable user_data {
  type        = string
  default     = ""
  description = "script to be run when the instance starts"
}

variable user_data_replace_on_change {
  type        = bool
  default     = true
}


