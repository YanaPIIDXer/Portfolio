resource "aws_lb" "default" {
    name = var.name
    internal = false
    load_balancer_type = "application"
    subnets = var.subnets
    security_groups = var.security_groups
    enable_deletion_protection = false
}

resource "aws_lb_target_group" "group" {
  count       = var.for_blue_green ? 2 : 1
  name        = join("", list(var.name, count.index + 1))
  port        = var.listen_port
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
  health_check {
      interval = 30
      path = "/"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
      matcher = 200
  }
}

resource "aws_lb_listener" "listener" {
    load_balancer_arn = aws_lb.default.arn
    port     = var.listen_port
    protocol = "HTTP"
    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.group[0].arn
    }
}
