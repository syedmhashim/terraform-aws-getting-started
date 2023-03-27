resource "aws_subnet" "this" {
  vpc_id     = var.vpc_id
  availability_zone = var.availability_zone
  cidr_block = var.subnet_cidr
  map_public_ip_on_launch = "true"
  tags = {
    Name = local.subnet_name
  }
}

resource "aws_eip" "this" {
  count = var.type == "public" && var.create_ngw == true ? 1 : 0
  vpc = true
  tags = {
    Name = local.eip_name
  }
}

resource "aws_nat_gateway" "this" {
  count = var.type == "public" && var.create_ngw == true ? 1 : 0
  allocation_id = aws_eip.this[0].id
  subnet_id     = aws_subnet.this.id
  tags = {
    Name = local.ngw_name
  }
}

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.type == "public" ? var.igw_id : null
    nat_gateway_id = var.type == "private" ? var.ngw_id : null
  }
  tags = {
    Name = local.route_table_name
  }
}

resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}