output "id" {
  value       = aws_ecr_repository.default.id
  description = "ID"
}

output "url" {
  value       = aws_ecr_repository.default.repository_url
  description = "リポジトリURL"
}
