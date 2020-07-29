resource "aws_ecs_cluster" "cluster" {
    name = var.name
}

resource "aws_ecs_service" "default" {
    name = var.name
    cluster = aws_ecs_cluster.cluster.arn
    task_definition = var.task
    desired_count = 1
    launch_type = "EC2"
    network_configuration {
        security_groups = var.security_groups
        subnets = var.subnets
    }
}
