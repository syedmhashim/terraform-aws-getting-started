resource "aws_instance" "public-server" {
  ami                    = "ami-0cff7528ff583bf9a"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.main-public.id
  vpc_security_group_ids = [aws_security_group.allow-public-access.id, aws_security_group.allow-ssh-access.id]
  key_name               = aws_key_pair.main-key-pair.key_name
  user_data = file("${path.module}/user_data.sh")
  user_data_replace_on_change = true
  tags = {
    Name = "public-server"
  }
}

resource "aws_instance" "private-server" {
  ami                    = "ami-0cff7528ff583bf9a"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.main-private.id
  vpc_security_group_ids = [aws_security_group.allow-ssh-access.id]
  key_name               = aws_key_pair.main-key-pair.key_name
  user_data_base64       = "IyEvYmluL2Jhc2gKeXVtIHVwZGF0ZSAteQp5dW0gaW5zdGFsbCBodHRwZCAteQpzeXN0ZW1jdGwgc3RhcnQgaHR0cGQKc3lzdGVtY3RsIGVuYWJsZSBodHRwZApjZCAvdmFyL3d3dy9odG1sCmVjaG8gIlByaXZhdGUgRUMyIiA+IGluZGV4Lmh0bWwK"
  tags = {
    Name = "private-server"
  }
}

resource "aws_key_pair" "main-key-pair" {
key_name = "main-key-pair"
public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits  = 4096
}

resource "local_file" "main-key" {
content  = tls_private_key.rsa.private_key_pem
filename = "main-key-pair"
}