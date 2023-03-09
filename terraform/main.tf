
provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "vuejsSecGroup" {
  description = "Allowing port 80 and 22"
  name        = "vuejs-beginner"

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

resource "aws_instance" "vuejs_server" {
  ami           = var.ami
  instance_type = var.instanceType
  key_name      = var.key-name

  security_groups = [aws_security_group.vuejsSecGroup.name]

  tags = {
    "Name" = "vuejs-beginner"
  }
}