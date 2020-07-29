
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
