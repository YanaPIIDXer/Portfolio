resource "aws_ecs_task_definition" "default" {
  family                   = var.family
  requires_compatibilities = ["EC2"]

  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execute_role_arn

  network_mode = "bridge"

  container_definitions = <<EOL
    [
        {
            "name": "${var.container_name}",
            "image": "${var.container_image}",
            "memory": ${var.container_memory},
            "environment": ${jsonencode(var.environments)},
            "portMappings":
            [
                {
                    "containerPort": ${var.container_port},
                    "hostPort": ${var.host_port}
                }
            ]
        }
    ]
  EOL
}
