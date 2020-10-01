module "load_balancer_sg" {
  source          = "../../SecurityGroup"
  name            = "${var.name}-LB-SG"
  vpc_id          = var.vpc_id
  ingress_rules   = [
    {
      from        = 0
      to          = 65535
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "load_balancer" {
  source          = "../../ELB"
  name            = "${var.name}-LB"
  vpc_id          = var.vpc_id
  listen_port     = var.container_port
  subnets         = var.subnets
  security_groups = [module.load_balancer_sg.id]
}

resource "aws_ecs_service" "service" {
  name            = var.name
  cluster         = var.cluster_name
  launch_type     = "EC2"
  desired_count   = 1
  task_definition = var.task_definition_arn
  iam_role        = "arn:aws:iam::310815347645:role/ecsServiceRole"
  load_balancer {
    target_group_arn = module.load_balancer.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  depends_on = [module.load_balancer.id]
}
