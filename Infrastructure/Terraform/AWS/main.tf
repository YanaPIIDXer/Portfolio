variable "key_name" {
}

provider "aws" {
  version = "~> 2.0"
  region  = "ap-northeast-1"
}

module "VPC" {
  source = "terraform-aws-modules/vpc/aws"
  
  name = "SlotSNS_VPC"
  cidr = "10.0.0.0/16"

  azs = ["ap-northeast-1a"]
  public_subnets = ["10.0.1.0/24"]
  private_subnets = ["10.0.2.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "SecurityGroup" {
  source = "terraform-aws-modules/security-group/aws"

  name = "SecurityGroup"
  description = "SlotSNS Security Group"
  vpc_id = module.VPC.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["ssh-tcp"]
}

module "SSHServer" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "SlotSNS_SSHServer"
  instance_count = 1
  ami = "ami-066b76d09a3d3ff4e"
  instance_type = "t2.micro"
  key_name = var.key_name
  vpc_security_group_ids = [module.SecurityGroup.this_security_group_id]
  subnet_id = module.VPC.public_subnets[0]
}
