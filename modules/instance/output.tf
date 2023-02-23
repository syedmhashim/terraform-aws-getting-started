output public_ip {
  value       = aws_instance.this.public_ip
  description = "public ip address"
}

output key_name {
  value       = var.key_name == null ? aws_key_pair.this[0].key_name : var.key_name
  description = "name for the key pair"
  depends_on  = [aws_key_pair.this[0]]
}
