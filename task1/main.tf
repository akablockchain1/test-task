provider "aws" {
  region = "eu-central-1" # Specify your AWS region
}

resource "aws_key_pair" "deployer" {
  key_name   = "terraform_key"
  public_key = file("~/.ssh/terraform_aws_key.pub")
}

resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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

resource "aws_instance" "web" {
  ami           = "ami-0d527b8c289b4af7f" # Update to a valid Ubuntu 20.04 AMI ID for your region
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  tags = {
    Name = "Terraform-EC2"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}
