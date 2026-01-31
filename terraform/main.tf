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

resource "aws_instance" "new-node" {
    ami           = "ami-096f46d460613bed4"
    instance_type = "t3.micro"

    tags = {
        Name = "new-node"
    }
}