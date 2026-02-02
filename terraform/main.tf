terraform {
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

# This resource ensures Terraform can "see" your default VPC
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# This resource adopts one of the default subnets (e.g., in availability zone 'a')
resource "aws_default_subnet" "default_az1" {
  availability_zone = "eu-west-1a"
}

resource "aws_instance" "new-node" {
  ami           = "ami-096f46d460613bed4"
  instance_type = "t3.micro"
  
  # By explicitly linking to the default subnet, you bypass the VPC error
  subnet_id     = aws_default_subnet.default_az1.id

  tags = {
    Name = "new-node"
  }
}
