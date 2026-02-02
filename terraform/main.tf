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

# Find subnets inside your specific VPC
data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = ["vpc-002855cca3304ddd7"]
  }
}

resource "aws_instance" "new-node" {
  ami           = "ami-096f46d460613bed4"
  instance_type = "t3.micro"
  
  # Grab the first subnet ID found
  subnet_id     = data.aws_subnets.all.ids[0]

  tags = {
    Name = "new-node"
  }
}
