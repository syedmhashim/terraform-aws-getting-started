### VPC ###
module "vpc" {
  source = "./modules/vpc"
  prefix = var.shared_prefix
  vpc_cidr = var.vpc_cidr
}


### SUBNETS ###
module "public_subnet" {
  source = "./modules/subnet"
  prefix = var.shared_prefix
  subnet_cidr = local.subnet["public"]["cidr_block"]
  type = "public"
  availability_zone = local.subnet["public"]["availability_zone"]
  vpc_id = module.vpc.vpc_id
  igw_id = module.vpc.igw_id
}

module "private_subnet" {
  source = "./modules/subnet"
  prefix = var.shared_prefix
  subnet_cidr = local.subnet["private"]["cidr_block"]
  type = "private"
  availability_zone = local.subnet["private"]["availability_zone"]
  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.public_subnet.subnet_id
}


### SECURITY GROUPS ###
module "public_ec2_sg" {
  source = "./modules/sg"
  prefix = var.shared_prefix
  name               = var.ec2_sg["public"]["name"]
  vpc_id             = module.vpc.vpc_id
  vpc_ingress        = var.ec2_sg["public"]["vpc_ingress"]
  vpc_egress         = var.ec2_sg["public"]["vpc_egress"]
}

module "private_ec2_sg" {
  source = "./modules/sg"
  prefix = var.shared_prefix
  name               = var.ec2_sg["private"]["name"]
  vpc_id             = module.vpc.vpc_id
  sg_ingress = [
    merge(var.ec2_sg["private"]["sg_ingress"]["http"], {
      source_security_group_id = module.public_ec2_sg.id
    })
  ]
  vpc_egress         = var.ec2_sg["private"]["vpc_egress"]
}

module "public_instance" {
  source = "./modules/instance"
  prefix = "${var.shared_prefix}-public"
  subnet_id = module.public_subnet.subnet_id
  sg_ids = [module.public_ec2_sg.id]
  user_data = templatefile(
    "${path.module}/user_data.tpl", {
      type = "public"
    }
  )
}

module "private_instance" {
  source = "./modules/instance"
  enable_public_ip = false
  prefix = "${var.shared_prefix}-private"
  subnet_id = module.private_subnet.subnet_id
  sg_ids = [module.private_ec2_sg.id]
  user_data = templatefile(
    "${path.module}/user_data.tpl", {
      type = "private"
    }
  )
  key_name = module.public_instance.key_name
}

output public_ec2_ip {
  value = module.public_instance.public_ip
}

output public_ec2_ssh_command {
  value = "ssh -i terraform-getting-started-public-key.pem ec2-user@${module.public_instance.public_ip}"
}