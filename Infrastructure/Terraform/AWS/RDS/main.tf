resource "aws_db_subnet_group" "subnet_group" {
  name       = join("", list(var.name, "_", "subnet_group"))
  subnet_ids = var.subnets
  tags = {
    Name = var.name
  }
}

resource "aws_db_option_group" "option_group" {
  name                 = var.identifier
  engine_name          = var.engine.prog
  major_engine_version = var.engine.major_version
}

resource "aws_db_parameter_group" "parameter_group" {
  name   = var.identifier
  family = join("", list(var.engine.prog, var.engine.version))

  parameter {
    name  = "character_set_server"
    value = var.charset.server
  }

  parameter {
    name  = "character_set_client"
    value = var.charset.client
  }

  parameter {
    name  = "time_zone"
    value = var.time_zone
  }
}

resource "aws_db_instance" "this" {
  identifier             = var.identifier
  storage_type           = var.storage.type
  allocated_storage      = var.storage.allocated_size
  engine                 = var.engine.prog
  engine_version         = var.engine.version
  instance_class         = var.instance_class
  name                   = var.db_name
  username               = var.root_data.name
  password               = var.root_data.password
  vpc_security_group_ids = var.security_groups
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  skip_final_snapshot    = true
  option_group_name      = aws_db_option_group.option_group.name
  parameter_group_name   = aws_db_parameter_group.parameter_group.name
}
