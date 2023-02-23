shared_prefix = "terraform-getting-started"
vpc_cidr = "10.0.0.0/16"

ec2_sg = {
  public = {
    name          = "public-ec2-sg"
    vpc_ingress = [{
      description = "http ingress from internet"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_blocks = ["0.0.0.0/0"]
    },{
      description = "ssh ingress from the internet"
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_blocks = ["0.0.0.0/0"]
    }]
    vpc_egress = [{
      description = "general egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }

  private = {
    name          = "private-ec2-sg"
    sg_ingress = {
      http ={
        description           = "http ingress from public ec2"
        protocol              = "tcp"
        from_port             = 80
        to_port               = 80
        source_security_group_id = null # Will be set on runtime
      }
    }
    vpc_egress = [{
      description = "general egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }
}