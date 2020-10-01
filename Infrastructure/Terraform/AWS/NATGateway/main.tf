resource "aws_eip" "nat_gw_eip" {
  vpc = true
}

resource "aws_nat_gateway" "default" {
  allocation_id     = aws_eip.nat_gw_eip.id
  subnet_id         = var.subnet.id
}
