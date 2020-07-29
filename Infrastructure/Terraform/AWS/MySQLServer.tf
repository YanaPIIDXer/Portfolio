variable "mysql_username" {}
variable "mysql_password" {}

module "MySQL_SecurityGroup" {
  source = "terraform-aws-modules/security-group/aws"

  name = "MySQL_SecurityGroup"
  description = "MySQL Security Group"
  vpc_id = module.VPC.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["mysql-tcp"]
}

module "MySQLServer" {
    source = "terraform-aws-modules/rds/aws"

    identifier = "mysqlserver"
    instance_class = "db.t3.micro"
    engine = "mysql"
    engine_version = "5.7"
    family = "mysql5.7"
    major_engine_version = "5.7"
    allocated_storage = 20
    maintenance_window = "Mon:00:00-Mon:03:00"
    backup_window = "03:00-06:00"
    port = "3306"
    username = var.mysql_username
    password = var.mysql_password
    vpc_security_group_ids = [module.MySQL_SecurityGroup.this_security_group_id]
    subnet_ids = module.VPC.private_subnets
    skip_final_snapshot = true
}
