variable "name" {
    default = "ELB"
    description = "名前"
}

variable "vpc_id" {
    description = "VPCのID"
}

variable "listen_port" {
    default = 80
    description = "ポート番号"
}

variable "subnets" {
    description = "サブネットの配列"
}

variable "security_groups" {
    description = "セキュリティグループの配列"
}

variable "for_blue_green" {
    default = false
    description = "Blue/Greenデプロイ用か？"
}
