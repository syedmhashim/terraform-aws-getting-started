resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name    = var.name
  }
}

resource "aws_security_group_rule" "sg_ingress_rules" {
  for_each = zipmap(range(length(var.sg_ingress)), var.sg_ingress)

  security_group_id = aws_security_group.this.id
  type              = "ingress"
  source_security_group_id = each.value.source_security_group_id
  protocol                 = each.value.protocol
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
}

resource "aws_security_group_rule" "vpc_ingress_rules" {
  for_each = zipmap(range(length(var.vpc_ingress)), var.vpc_ingress)

  security_group_id = aws_security_group.this.id
  type              = "ingress"

  cidr_blocks = each.value.cidr_blocks
  protocol    = each.value.protocol
  from_port   = each.value.from_port
  to_port     = each.value.to_port
}

resource "aws_security_group_rule" "vpc_egress_rules" {
  for_each = zipmap(range(length(var.vpc_egress)), var.vpc_egress)

  security_group_id = aws_security_group.this.id
  type              = "egress"

  cidr_blocks = each.value.cidr_blocks
  protocol    = each.value.protocol
  from_port   = each.value.from_port
  to_port     = each.value.to_port
}