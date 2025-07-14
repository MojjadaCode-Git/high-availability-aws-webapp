resource "aws_instance" "web" {
  ami           = "ami-0c02fb55956c7d316"  # Amazon Linux 2 AMI (update if needed)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = "your-key"
  security_groups = [aws_security_group.web_sg.id]

  user_data = file("${path.module}/setup.sh")

  tags = {
    Name = "web-server"
  }
}
