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

// ルートテーブル（public）
module "public_route_table" {
  source  = "./RouteTable"
  name    = "SlotSNS_RouteTable_Public"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  gateway_routes = [
    {
      id         = module.vpc.internet_gateway_id
      cidr_block = "0.0.0.0/0"
    }
  ]
}

// NATゲートウェイ
module "nat_gateway" {
  source = "./NATGateway"
  subnet = module.vpc.public_subnets[0]
}

// ルートテーブル(Private)
module "privae_route_table" {
  source  = "./RouteTable"
  name    = "SlotSNS_RouteTable_Private"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets
  nat_gateway_routes = [
    {
      id         = module.nat_gateway.id
      cidr_block = "0.0.0.0/0"
    }
  ]
}
