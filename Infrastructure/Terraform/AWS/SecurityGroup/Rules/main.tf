resource "aws_security_group_rule" "default" {
  count = length(var.rules) * (var.make ? 1 : 0)

  security_group_id = var.security_group_id
  type              = var.type
  from_port         = var.rules[count.index].from
  to_port           = var.rules[count.index].to
  protocol          = var.rules[count.index].protocol
  cidr_blocks       = var.rules[count.index].cidr_blocks
}
