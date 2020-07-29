module "SSH_SecurityGroup" {
  source = "terraform-aws-modules/security-group/aws"

  name = "SSH_SecurityGroup"
  description = "SSH Security Group"
  vpc_id = module.VPC.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["ssh-tcp"]
}

module "SSHServer" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "SlotSNS_SSHServer"
  instance_count = 1
  ami = "ami-0cc75a8978fbbc969"     // Amazon Linux2
  instance_type = "t2.micro"
  key_name = var.key_name
  vpc_security_group_ids = [module.SSH_SecurityGroup.this_security_group_id]
  subnet_id = module.VPC.public_subnets[0]
}
