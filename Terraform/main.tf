terraform {
  required_version = ">= 1.6.0"


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}


# -------------------------
# Web Node Security Group
# -------------------------
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH and HTTP (Port 80)  inbound, all outbound"
  vpc_id      = "vpc-05fa8ac4aed113526"


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

  tags = {
    Name = "web-security-group"
  }
}

#-----------------------------
# Python Node Security Group
#-----------------------------
resource "aws_security_group" "python_sg" {
  name        = "python-sg"
  description = "Allow SSH and Python app (port 8080)"
  vpc_id      = "vpc-05fa8ac4aed113526"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Python App"
    from_port   = 8080
    to_port     = 8080
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
    Name = "python-security-group"
  }
}

#----------------------------
# Java Node Security Group
#----------------------------
resource "aws_security_group" "java_sg" {
  name        = "java-sg"
  description = "Allow SSH and Java app (port 9090)"
  vpc_id      = "vpc-05fa8ac4aed113526"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Java App"
    from_port   = 9090
    to_port     = 9090
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
    Name = "java-security-group"
  }
}

#--------------------------
# Node 1: Nginx Frointend
#--------------------------
resource "aws_instance" "web_node" {
  ami           = "ami-097409ef90cde4a3f"
  instance_type = "t3.micro"
  subnet_id     = "subnet-0579e08acc73f5ab6"
  vpc_security_group_ids = ["sg-07b36c225318b0dda"]
  key_name = "BlackDot"

  tags = {
    Name = "web_node_frontend"
  }
}

#-------------------------
# Node 2: Python Backend
#-------------------------
resource "aws_instance" "python_node" {
  ami                    = "ami-0330f47320d53fd91"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-0579e08acc73f5ab6"
  vpc_security_group_ids = ["sg-07b36c225318b0dda"]
  key_name               = "BlackDot"

  tags = {
    Name = "python_node_backend"
      }
}

#-----------------------
# Node 3: Java Backend
#-----------------------
resource "aws_instance" "java_node" {
  ami                    = "ami-098fc3f1217942a8e"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-0579e08acc73f5ab6"
  vpc_security_group_ids = ["sg-07b36c225318b0dda"]
  key_name               = "BlackDot"

  tags = {
    Name = "java_node_backend"
    }
}
