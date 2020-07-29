provider "aws" {
  version = "~> 2.0"
  region  = "ap-northeast-1"
}

module "VPC" {
  source = "./AWSModule_VPC"
  
  name = "SlotSNS_VPC"
  cidr = "10.0.0.0/16"

  azs             = ["ap-northeast-1a"]
  private_subnets = ["10.0.0.1/24"]
  public_subnets  = ["10.0.0.2/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
