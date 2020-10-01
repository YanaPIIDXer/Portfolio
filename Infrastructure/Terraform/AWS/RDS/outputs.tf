output "id" {
  value       = aws_db_instance.this.id
  description = "RDSインスタンスのＩＤ"
}

output "address" {
  value       = aws_db_instance.this.address
  description = "RDSインスタンスへのアドレス"
}
