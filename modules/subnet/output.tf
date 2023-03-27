output subnet_id {
  value       = aws_subnet.this.id
  description = "id of the subnet created"
}

output "ngw_id" {
  value = var.type == "public" && var.create_ngw == true ? aws_nat_gateway.this[0].id : null
}
