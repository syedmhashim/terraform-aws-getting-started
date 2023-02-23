output vpc_id {
  value       = aws_vpc.this.id
  description = "vpc id"
}

output igw_id {
  value       = aws_internet_gateway.this.id
  description = "internet gateway id"
}

