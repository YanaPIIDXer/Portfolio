output "id" {
    value = aws_lb.default.id
    description = "ELBのID"
}

output "arn" {
    value = aws_lb.default.arn
    description = "ELBのARN"
}

output "listener_arn" {
    value = aws_lb_listener.listener.arn
    description = "リスナのARN"
}

output "target_group_name" {
    value = aws_lb_target_group.group[0].name
    description = "TargetGroupの名前"
}

output "target_group_arn" {
    value = aws_lb_target_group.group[0].arn
    description = "TargetGroupのARN"
}

output "sub_target_group_name" {
    value = var.for_blue_green ? aws_lb_target_group.group[1].name : ""
    description = "Blue/Greenデプロイ用のTargetGroup名"
}
