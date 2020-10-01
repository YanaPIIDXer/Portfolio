output "id" {
  value       = aws_ecs_task_definition.default.id
  description = "ID"
}

output "arn" {
  value       = aws_ecs_task_definition.default.arn
  description = "ARN"
}
