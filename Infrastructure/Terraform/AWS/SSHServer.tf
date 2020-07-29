module "SSHServer" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "SlotSNS_SSHServer"
  instance_count = 1
  // ↓Amazon Linux
  ami = "ami-07f31579a94d28584"
  // ↓Amazon Linux2
  //  何か知らんけどRDSが依存してる上にこれに変えるとRDSの再構築に失敗する。
  //ami = "ami-066b76d09a3d3ff4e"
  instance_type = "t2.micro"
  key_name = var.key_name
  vpc_security_group_ids = [module.SecurityGroup.this_security_group_id]
  subnet_id = module.VPC.public_subnets[0]
}
