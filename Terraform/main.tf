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
  description = "Allow SSH and Port 80  inbound, all outbound"

}




resource "aws_instance" "web_node" {
  ami           = "ami-002075433fbd7ba04"
  instance_type = "t3.micro"
  subnet_id     = "subnet-0828482fafcb40dc8"
    key_name = "BlackDot"

  tags = {
    Name = "web_node"
  }
}