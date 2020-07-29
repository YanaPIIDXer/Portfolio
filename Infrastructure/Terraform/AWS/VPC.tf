module "VPC" {
  source = "terraform-aws-modules/vpc/aws"
  
  name = "SlotSNS_VPC"
  cidr = "10.0.0.0/21"

  azs = ["ap-northeast-1a", "ap-northeast-1c"]
  public_subnets = ["10.0.1.0/24"]
  private_subnets = ["10.0.2.0/24", "10.0.3.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
