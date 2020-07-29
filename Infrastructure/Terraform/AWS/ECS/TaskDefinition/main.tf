resource "aws_ecs_task_definition" "default" {
  family = var.family

  requires_compatibilities = ["EC2"]
  cpu = var.cpu
  memory = var.memory
  network_mode = "awsvpc"

  container_definitions = <<EOL
    [
        {
            "name": "${var.container_name}",
            "image": "${var.image}",
            "portMappings": [
                {
                    "containerPort": ${var.container_port},
                    "hostPort": ${var.host_port}
                }
            ]
        }
    ]
    EOL
}
