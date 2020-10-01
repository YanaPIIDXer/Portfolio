resource "aws_route_table" "default" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.name
  }
}

resource "aws_route" "gateway_route" {
  count                  = length(var.gateway_routes)
  route_table_id         = aws_route_table.default.id
  gateway_id             = var.gateway_routes[count.index].id
  destination_cidr_block = var.gateway_routes[count.index].cidr_block
}

resource "aws_route" "nat_gateway_route" {
  count                  = length(var.nat_gateway_routes)
  route_table_id         = aws_route_table.default.id
  nat_gateway_id         = var.nat_gateway_routes[count.index].id
  destination_cidr_block = var.nat_gateway_routes[count.index].cidr_block
}

resource "aws_route_table_association" "subnet_association" {
  count          = length(var.subnets)
  route_table_id = aws_route_table.default.id
  subnet_id      = var.subnets[count.index].id
}
