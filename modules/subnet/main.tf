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
  count = var.type == "private" ? 1 : 0
  vpc = true
}

resource "aws_nat_gateway" "this" {
  count = var.type == "private" ? 1 : 0
  allocation_id = aws_eip.this[0].id
  subnet_id     = var.public_subnet_id
}

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.type == "public" && var.igw_id != null ? var.igw_id : null
    nat_gateway_id = var.type == "private" ? aws_nat_gateway.this[0].id : null
  }
  tags = {
    Name = local.route_table_name
  }
  depends_on = [aws_nat_gateway.this]
}

resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}