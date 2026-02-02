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

# 1. Look up your specific VPC by ID
data "aws_vpc" "manual_vpc" {
  id = "vpc-002855cca3304ddd7"
}

# 2. Automatically find the subnets that belong to that VPC
data "aws_subnets" "manual_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.manual_vpc.id]
  }
}

resource "aws_instance" "new-node" {
  ami           = "ami-096f46d460613bed4"
  instance_type = "t3.micro"
  
  # 3. Use the first available subnet found in that VPC
  subnet_id     = data.aws_subnets.manual_subnets.ids[0]

  tags = {
    Name = "new-node"
  }
}
