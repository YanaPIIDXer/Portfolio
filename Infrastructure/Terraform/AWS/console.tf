// コンソール操作用のSecurityGroup
module "console_sg" {
  source = "./SecurityGroup"
  vpc_id         = module.vpc.vpc_id
  gateway_routes = [module.vpc.internet_gateway_id]
  enable_ssh = true
}

// コンソール操作用EC2インスタンス
module "console_instance" {
  source = "./EC2"
  name = "SlotSNS_ConsoleInstance"
  subnet = module.vpc.public_subnets[0]
  security_groups = [module.console_sg.id]
  key_name = var.key_name
}
