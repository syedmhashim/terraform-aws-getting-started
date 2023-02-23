resource "aws_key_pair" "this" {
  count = var.key_name == null ? 1 : 0
  key_name = local.key_name
  public_key = tls_private_key.this[0].public_key_openssh
}

resource "tls_private_key" "this" {
  count = var.key_name == null ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "this" {
  count = var.key_name == null ? 1 : 0
  content  = tls_private_key.this[0].private_key_pem
  filename = local.key_file_name
  provisioner "local-exec" {
    command = "chmod 400 ${local.key_file_name}"
  }
}

resource "aws_instance" "this" {
  ami                    = var.ami
  associate_public_ip_address = var.enable_public_ip
  instance_type          = var.type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.sg_ids
  key_name               = var.key_name == null ? aws_key_pair.this[0].key_name : var.key_name
  user_data = var.user_data
  user_data_replace_on_change = var.user_data_replace_on_change
  tags = {
    Name = local.instance_name
  }
}