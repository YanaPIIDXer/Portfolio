resource "aws_ecs_task_definition" "default" {
    family = var.family

    requires_compatibilities = ["EC2"]
    cpu = var.cpu
    memory = var.memory
    network_mode = "bridge"

    container_definitions = <<EOL
    [
        {
            "name": "${var.container_name}",
            "image": "${var.image}",
            "portMappings": [
                {
                    "hostPort": ${var.host_port},
                    "containerPort": ${var.container_port},
                    "protocol": "${var.protocol}"
                }
            ]
        }
    ]
    EOL
}

output "arn" {
    value = aws_ecs_task_definition.default.arn
}
