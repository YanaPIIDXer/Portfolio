output "cluster_id" {
  value       = aws_ecs_cluster.cluster.id
  description = "クラスタのID"
}

output "cluster_name" {
  value       = aws_ecs_cluster.cluster.name
  description = "クラスタの名前"
}

output "service_id" {
  value       = module.service.id
  description = "サービスのID"
}

output "service_name" {
  value       = module.service.name
  description = "サービスの名前"
}
