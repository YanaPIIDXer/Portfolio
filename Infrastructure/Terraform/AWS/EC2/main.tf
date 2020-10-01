resource "aws_instance" "default" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet.id
  security_groups             = var.security_groups
  availability_zone           = var.subnet.availability_zone
  associate_public_ip_address = var.associate_public_ip_address
  user_data                   = var.user_data
  key_name                    = var.key_name

  tags = {
    Name = var.name
  }
}
