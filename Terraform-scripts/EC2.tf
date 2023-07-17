resource "aws_instance" "Ngnix-server" {
  count         = 3
  ami           = "ami-0f5ee92e2d63afc18" # Replace with your desired AMI ID
  instance_type = "t2.micro"             # Replace with your desired instance type
  key_name      = "abdul-ansible-key"  # Replace with your EC2 key name

  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = "Ngnix-server-${count.index + 1}"
  }
}

output "public_ip" {
  value = aws_instance.Ngnix-server[*].public_ip
}
