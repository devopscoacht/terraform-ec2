# Create a security group
resource "aws_security_group" "web_server_sg" {
  name        = "web-server-sg"
  description = "Allow SSH and HTTP"
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "web_server" {
  ami               = var.ami_id
  instance_type     = "t2.micro"
  key_name          = var.key_name
  security_groups   = [aws_security_group.web_server_sg.name]
  associate_public_ip_address = true

  tags = {
    Name = "WebServer"
  }
}
