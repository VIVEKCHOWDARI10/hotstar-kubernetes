terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  region = "ap-south-1"
}

# Create Security Group
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2 security group"
  description = "allow access on ports 22"

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Monitoring server security group"
  }
}

# Create EC2 Instance
resource "aws_instance" "Monitoring_server" {
  ami                    = "ami-00bb6a80f01f03502"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  key_name               = var.key_name

  tags = {
    Name = var.instance_name
  }
}
