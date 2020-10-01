provider "aws" {
  version = "~> 2.0"
  region  = "ap-northeast-1"
}

// VPC
module "vpc" {
  source     = "./VPC"
  name       = "SlotSNS"
  cidr_block = "10.1.0.0/16"
  public_subnets = [
    {
      cidr_block        = "10.1.0.0/24"
      availability_zone = "ap-northeast-1a"
    }
  ]
  private_subnets = [
    {
      cidr_block        = "10.1.1.0/24"
      availability_zone = "ap-northeast-1a"
    },
    {
      cidr_block        = "10.1.2.0/24"
      availability_zone = "ap-northeast-1c"
    }
  ]
}
