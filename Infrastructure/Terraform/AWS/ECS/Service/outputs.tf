output "id" {
  value       = aws_ecs_service.service.id
  description = "サービスのID"
}

output "name" {
  value       = aws_ecs_service.service.name
  description = "サービスの名前"
}

output "elb_sg_id" {
  value = module.load_balancer_sg.id
  description = "ロードバランサー用のSecurityGroupのID"
}
