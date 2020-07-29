provider "aws" {
  version = "~> 2.0"
  region  = "ap-northeast-1"
}

module "SlotSNS_VPC" {
  source = "./VPC"
}
