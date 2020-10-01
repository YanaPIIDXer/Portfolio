output "vpc_id" {
  value       = aws_vpc.default.id
  description = "生成されたVPCのID"
}

output "public_subnets" {
  value       = aws_subnet.public_subnets
  description = "パブリックサブネットの配列"
}

output "private_subnets" {
  value       = aws_subnet.private_subnets
  description = "プライベートサブネットの配列"
}

output "internet_gateway_id" {
  value       = length(aws_internet_gateway.internet_gateway) > 0 ? aws_internet_gateway.internet_gateway[0].id : null
  description = "インターネットゲートウェイのＩＤ。パブリックサブネットが存在しない場合はnullを返す。"
}
