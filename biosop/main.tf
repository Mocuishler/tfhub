terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "cndemo"
  region  = "cn-northwest-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"


  for_each = toset(["A", "B"])

  name = "TF-${each.key}"

  cidr = "10.0.0.0/16"

  azs             = ["cn-northwest-1a","cn-northwest-1b","cn-northwest-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}