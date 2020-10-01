resource "aws_security_group" "default" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.name
  }
}

module "ingress_rules" {
  source = "./Rules"

  security_group_id = aws_security_group.default.id
  type              = "ingress"
  rules             = var.ingress_rules
}

module "egress_rules" {
  source = "./Rules"

  type              = "egress"
  security_group_id = aws_security_group.default.id
  rules             = var.egress_rules
}

module "ssh_rules" {
  source = "./Rules"

  security_group_id = aws_security_group.default.id
  make              = var.enable_ssh
  type              = "ingress"
  rules = [{
    from        = 22
    to          = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }]
}

module "http_rules" {
  source = "./Rules"

  security_group_id = aws_security_group.default.id
  make              = var.enable_http
  type              = "ingress"
  rules = [{
    from        = 80
    to          = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }]
}

module "mysql_rules" {
  source = "./Rules"

  security_group_id = aws_security_group.default.id
  make              = var.enable_mysql
  type              = "ingress"
  rules = [{
    from        = 3306
    to          = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }]
}
